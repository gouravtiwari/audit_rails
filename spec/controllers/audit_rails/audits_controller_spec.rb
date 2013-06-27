require 'spec_helper'

describe AuditRails::AuditsController do
  context 'routes' do
    it { expect(:get => "/audits").to route_to( 
      :controller => "audit_rails/audits", 
      :action => "index" )
    }
    
    it { expect(:post => "/audits").to route_to( 
      :controller => "audit_rails/audits", 
      :action => "create" )
    }
  end

  context "GET index" do
    it "lists audits" do
      audit = stub_model(AuditRails::Audit)
      AuditRails::Audit.stub(:all) { [audit] }
      
      get 'index'

      expect(assigns(:audits)).to eq([audit])
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