module AuditRails
  class Audit < ActiveRecord::Base
    def self.needs_attr_accessible?
      Rails::VERSION::MAJOR == 3
    end

    if needs_attr_accessible?
      attr_accessible :action, :controller, :description, :user_name
    end

    def self.no_audit_entry_for_today?(action_name, user_name)
      audits = where(action: action_name, user_name: user_name, 
        created_at: Time.now.to_date.beginning_of_day..Time.now.to_date.end_of_day)
      
      audits.blank?
    end

    def self.analysis_by_user_name
      count(group: 'user_name')
    end

    def self.analysis_by_page_views
      count(group: 'controller,action')
    end
  end
end
