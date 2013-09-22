require_dependency "audit_rails/application_controller"

module AuditRails
  class AuditsController < ApplicationController

    def index
      @audits = AuditRails::Audit.all
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @audits }
        format.xls { send_data @audits.to_xls(:columns => [:user_name, :action, :description, :created_at], 
          :headers => ['User name', 'Action', 'Details', 'When?']), filename: 'audits.xls'}

      end
    end

    def create
      add_to_audit("visit-site", "xyz", "Fake User")
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end

    def analytics
    end
  end
end
