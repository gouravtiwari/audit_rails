require 'spec_helper'

describe AuditRails::ApplicationController do

# Sets up an anonymous controller for checking ApplicationController logic
  controller do
    
    # Either you add add_to_audit to before filter
    # or you call it from current_user method
    before_filter do |c| 
      app_controller = AuditRails::ApplicationController.new
      app_controller.add_to_audit(request.params[:action], request.params[:controller], 'Fake User', 'User logged in')
    end

    # A fake login
    def login
      render :text => 'Ok'
    end
  end

  describe 'audit login action' do
    before do
      # Redrawing routes is important to make sure we do not get routing error
      @routes.draw do
        get '/anonymous/login'
      end
    end
    
    it 'when user logs in' do
      get :login, :id => 1

      response.should be_success
      AuditRails::Audit.no_audit_entry_for_today?('login', 'Fake User').should be_false
    end
  end
end