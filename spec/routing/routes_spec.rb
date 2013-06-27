require 'spec_helper'

describe 'Routes' do
  
  it { expect(:get => "/audits").to route_to( 
    :controller => "audit_rails/audits", 
    :action => "index" )
  }
  
  it { expect(:post => "/audits").to route_to( 
    :controller => "audit_rails/audits", 
    :action => "create" )
  }  
end