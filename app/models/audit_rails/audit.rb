module AuditRails
  class Audit < ActiveRecord::Base
    attr_accessible :action, :controller, :description, :user_name

    def self.no_audit_entry_for_today?(action_name, user_name)
      audits = where(action: action_name, user_name: user_name, 
        created_at: Time.now.to_date.beginning_of_day..Time.now.to_date.end_of_day)
      
      audits.blank?
    end
  end
end
