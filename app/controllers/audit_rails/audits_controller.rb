require_dependency "audit_rails/application_controller"

module AuditRails
  class AuditsController < ApplicationController
    before_filter(:only => :create) {|c| add_to_audit("visit-site", "xyz", "Fake User")}

    def index
      @audits = AuditRails::Audit.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @audits }
      end
    end

    def create
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end

  end
end
