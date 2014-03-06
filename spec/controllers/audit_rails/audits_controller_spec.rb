require 'spec_helper'

describe AuditRails::AuditsController do
  # Need to push this to spec/routing directory
  context 'routes' do
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
      AuditRails::Audit.stub(:in_range).and_return(stub(count: count = 9,
        analysis_by_user_name: user_list = {"Fake User"=>6, "John Smith"=>3},
        analysis_by_page_views: page_list = {"visit-site"=>6, "login"=>3},
        analysis_per_user_by_page_views: users_by_page_list = {"Fake User"=> [{"page"=>"visit-site", "count"=>4},
                                                                              {"page"=>"login", "count"=>2}], 
                                                                "John Smith" => [{"page"=>"visit-site", "count"=>2},
                                                                              {"page"=>"login", "count"=>1}]
                                                              },
        analysis_by_hourly_views: hourly_list = {"01"=>6, "23"=>3},
        ))
      AuditRails::Audit.stub(:count_by_day).and_return(stub("{\"Date\":\"Count\",\"20140303\":6,\"20140304\":3,\"20140305\":0,\"20140306\":0}"))

      get 'analytics'

      expect(assigns(:total)).to eq(count)
      expect(assigns(:analysis_by_user_name)).to eq(user_list)
      expect(assigns(:analysis_by_page_views)).to eq(page_list)
      expect(assigns(:analysis_per_user_by_page_views)).to eq(users_by_page_list)
      expect(assigns(:analysis_by_hourly_views)).to eq(hourly_list)
    end
  end
end
