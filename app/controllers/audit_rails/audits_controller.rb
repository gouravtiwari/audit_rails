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
      @range_begin = params[:analytics] ? params[:analytics][:range_begin] : nil
      @range_end   = params[:analytics] ? params[:analytics][:range_end] : nil
      @analysis_by_user_name  = AuditRails::Audit.in_range(@range_begin, @range_end).analysis_by_user_name
      @analysis_by_page_views = AuditRails::Audit.in_range(@range_begin, @range_end).analysis_by_page_views
      @total = AuditRails::Audit.in_range(@range_begin, @range_end).count
    end
  end
end
