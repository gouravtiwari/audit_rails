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
      AuditRails::Audit.stub(:count_by_day).and_return(count_by_day = stub("{\"Date\":\"Count\",\"20140303\":6,\"20140304\":3,\"20140305\":0,\"20140306\":0}"))

      get 'analytics'

      expect(assigns(:analysis)).to eq({
                                          "by_user_name"=>{"Fake User"=>6, "John Smith"=>3}, 
                                          "by_page_views"=>{"visit-site"=>6, "login"=>3}, 
                                          "per_user_by_page_views"=>{"Fake User"=>[{"page"=>"visit-site", "count"=>4}, {"page"=>"login", "count"=>2}], "John Smith"=>[{"page"=>"visit-site", "count"=>2}, {"page"=>"login", "count"=>1}]}, 
                                          "by_hourly_views"=>{"01"=>6, "23"=>3}, 
                                          "total"=>9, 
                                          "count_by_day"=>count_by_day
                                        })
    end
  end
end
