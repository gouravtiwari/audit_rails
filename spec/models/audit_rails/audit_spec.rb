require 'spec_helper'
describe AuditRails::Audit do
  describe ".no_audit_entry_for_today?" do
    it "returns true when there is no audit entry for a user for an action " do
      AuditRails::Audit.no_audit_entry_for_today?('login', 'John').should be_true
    end

    it "returns false when there is an audit entry for a user for an action to avoid duplicate entries (e.g. for login)" do
      audit = AuditRails::Audit.create!(:action => action = "login", :user_name => user = "John Smith")

      AuditRails::Audit.no_audit_entry_for_today?(action, user).should be_false
    end
  end
end