require_dependency "audit_rails/application_controller"

module AuditRails
  class AuditsController < ApplicationController

    def index
      @audits = AuditRails::Audit.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @audits }
      end
    end

    def create
      add_to_audit("visit-site", "xyz", "Fake User")
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end

  end
end
