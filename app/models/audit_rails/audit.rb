module AuditRails
  class Audit < ActiveRecord::Base
    def self.needs_attr_accessible?
      Rails::VERSION::MAJOR == 3
    end

    if needs_attr_accessible?
      attr_accessible :action, :controller, :description, :user_name, :ip_address
    end

    # Supports both string and date format of range given
    scope :in_range, ->(range_begin, range_end){
      if range_end.blank? || range_end.blank?
        range_begin, range_end = '1970-01-01', Time.now
      end
      where(created_at: range_begin.to_date.beginning_of_day..range_end.to_date.end_of_day)
      }

    scope :reverse_chronological, ->{order('created_at DESC')}
    scope :group_by_controller_action, ->{group([:controller, :action])}
    scope :group_by_user_name, ->{group('user_name')}
    scope :group_by_ip_address, ->{group('ip_address')}

    def self.no_audit_entry_for_today?(action_name, user_name)
      audits = where(action: action_name, user_name: user_name, 
        created_at: Time.now.to_date.beginning_of_day..Time.now.to_date.end_of_day)
      
      audits.blank?
    end

    def self.analysis_by_user_name
      group_by_user_name.count.map{|k,v| {'user' => k, 'count' => v}}.to_json
    end

    def self.analysis_by_page_views
      group_by_controller_action.count.map{|k,v| {'page' => k.join('/'), 'count' => v}}.to_json
    end

    def self.unique_visitor_count
      group_by_ip_address.count.values.size
    end

    def self.visitor_count
      group_by_ip_address.count.values.sum
    end
  end
end
