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
      audits = (1..3).map {|t| FactoryGirl.create(:audit, user_name: 'Fake User', 
        description: "User logged on at #{t.days.ago}",
        action: 'login',
        controller: 'sessions')}

      get 'index'

      expect(assigns(:audits)).to eq(audits)
    end


    it "lists audits in excel" do
      audits = (1..3).map {|t| FactoryGirl.create(:audit, user_name: 'Fake User', 
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

  context "GET analytics" do
    it "shows analytics of audits on page" do
      # list should be a hash
      AuditRails::Audit.stub(:count).and_return(count = 18)
      AuditRails::Audit.stub(:analysis_by_user_name).and_return(user_list = {"Fake User"=>6, "John Smith"=>3})
      AuditRails::Audit.stub(:analysis_by_page_views).and_return(page_list = {"visit-site"=>6, "login"=>3})

      get 'analytics'

      expect(assigns(:total)).to eq(count)
      expect(assigns(:analysis_by_user_name)).to eq(user_list)
      expect(assigns(:analysis_by_page_views)).to eq(page_list)
    end
  end
end