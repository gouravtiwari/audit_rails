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

  describe ".analysis_by_user_name" do
    it "returns users and count for all audits in the system" do
      john = "John Smith"
      fake = "Fake User"
      audit = 3.times{
        AuditRails::Audit.create!(:action => action = "Visit", :user_name => john)
        AuditRails::Audit.create!(:action => action = "Visit", :user_name => fake)
      }

      AuditRails::Audit.analysis_by_user_name.should == {john => 3, fake => 3}
    end
  end

    describe ".analysis_by_page_views" do
    it "returns controller-action and count for all audits in the system" do
      john = "John Smith"
      fake = "Fake User"
      audit = 3.times{
        AuditRails::Audit.create!(:action => action = "Visit", :user_name => john)
        AuditRails::Audit.create!(:action => action = "login", :user_name => fake)
      }

      AuditRails::Audit.analysis_by_page_views.should == {'login' => 3, 'Visit' => 3}
    end
  end

end