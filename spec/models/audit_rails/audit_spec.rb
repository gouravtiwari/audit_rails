require 'spec_helper'
describe AuditRails::Audit do
  describe ".no_audit_entry_for_today?" do
    it "returns true when there is no audit entry for a user for an action " do
      audit = AuditRails::Audit.create!(:action => action = "login", :user_name => user = "John Smith")
      AuditRails::Audit.no_audit_entry_for_today?(action, user).should be_true
    end
  end
end