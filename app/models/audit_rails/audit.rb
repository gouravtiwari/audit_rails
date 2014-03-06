module AuditRails
  class Audit < ActiveRecord::Base
    extend AuditRails::DBExtension

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
    scope :group_by_hours, ->{group(hourly('created_at'))}

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

    def self.analysis_per_user_by_page_views
      users = {}
      group_by_user_name.group_by_controller_action.count.map do |k, v|
        value = [{"page" => "#{k[1]}/#{k[2]}", "count" => v}]
        users[k[0]] = users[k[0]] ? users[k[0]] + value : value
      end
      users.to_json
    end

    def self.unique_visitor_count
      group_by_ip_address.count.values.size
    end

    def self.visitor_count
      group_by_ip_address.count.values.sum
    end

    def self.analysis_by_hourly_views
      hourly_counts = Hash[group_by_hours.count.map{|k,v| [k.to_i, v]}]
      hourly_series = Array.new(24, 0)

      hourly_series.each.with_index do |a, i|
        hourly_series[i] = hourly_counts[i] if hourly_counts[i]
      end

      hourly_series.map.with_index{|v,i| {'hour' => i.to_s.rjust(2,'0')+":00", 'count' => v}}.to_json
    end

    def self.count_by_day(start_date, end_date)
      dates = start_date.to_date..end_date.to_date
      records = AuditRails::Audit.where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day).order('created_at')
      records = records.group_by{|audit| audit.created_at.to_date.strftime('%Y%m%d')}

      overall_counts = Hash.new(0)
      overall_counts['Date']='Count'

      records.each do |date, audits|
        overall_counts[date] = audits.count
      end

      dates = dates.map{|d| d.strftime('%Y%m%d')}

      dates.each do |date|
        overall_counts[date] = "#{overall_counts[date]}".to_i
      end

      overall_counts.to_json
    end
  end
end
