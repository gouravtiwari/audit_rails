require 'spec_helper'

describe AuditRails::AuditsController do
  # Need to push this to spec/routing directory
  context 'routes' do
    it { expect(:get => "/audits").to route_to( 
      :controller => "audit_rails/audits", 
      :action => "index" )
    }
    
    it { expect(:post => "/audits").to route_to( 
      :controller => "audit_rails/audits", 
      :action => "create" )
    }

    it { expect(:get => "/audits/analytics").to route_to(
      :controller => "audit_rails/audits",
      :action => 'analytics'
      )
    }
  end

  context "GET index" do
    it "lists audits on page" do
      audits = (1..3).map {|t| AuditRails::Audit.create(user_name: 'Fake User', 
        description: "User logged on at #{t.days.ago}",
        action: 'login',
        controller: 'sessions')}

      get 'index'

      expect(assigns(:audits)).to eq(audits)
    end


    it "lists audits in excel" do
      audits = (1..3).map {|t| AuditRails::Audit.create(user_name: 'Fake User', 
        description: "User logged on at #{t.days.ago}",
        action: 'login',
        controller: 'sessions')}

      get 'index', format: 'xls'

      response.should be_success
      expect(assigns(:audits)).to eq(audits)
    end
  end

  context 'POST audit' do
    it 'should post an audit' do
      post 'create'

      response.should be_success
      AuditRails::Audit.no_audit_entry_for_today?("visit-site", 'Fake User').should be_false
    end
  end
end