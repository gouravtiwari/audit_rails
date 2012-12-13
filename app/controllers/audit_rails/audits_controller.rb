require_dependency "audit_rails/application_controller"

module AuditRails
  class AuditsController < ApplicationController
    before_filter(:only => :create) {|c| c.add_to_audit("visit-site", "xyz")}

    def index
      @audits = Audit.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @audits }
      end
    end

    def create
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end

    private
    
    def add_to_audit(action_name=nil, controller_name=nil, user_name=nil)
      if action_name == "login"
        if Audit.no_audit_entry?(action_name, user_name)
        Audit.create(action: action_name, controller: controller_name, user_name: user_name)
        end
      else
        Audit.create(action: action_name || request.params[:action],
        controller: controller_name || request.params[:controller],
        user_name: current_user.name)
      end
    end

  end
end
