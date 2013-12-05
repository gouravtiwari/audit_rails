require_dependency "audit_rails/application_controller"

module AuditRails
  class AuditsController < ApplicationController
    before_filter :apply_filter, except: [:create]

    def create
      add_to_audit("visit-site", "xyz", "Fake User")
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end

    def analytics
      @analysis_by_user_name  = AuditRails::Audit.in_range(@range_begin, @range_end).analysis_by_user_name
      @analysis_by_page_views = AuditRails::Audit.in_range(@range_begin, @range_end).analysis_by_page_views
      @analysis_per_user_by_page_views  = AuditRails::Audit.in_range(@range_begin, @range_end).analysis_per_user_by_page_views
      @analysis_by_hourly_views  = AuditRails::Audit.in_range(@range_begin, @range_end).analysis_by_hourly_views

      @total = AuditRails::Audit.in_range(@range_begin, @range_end).count
      @no_audits = AuditRails::Audit.count == 0

      if params[:commit] == "Download Filtered Report"
        find_all_audits
        send_data(@audits.to_xls(:columns => [:user_name, :action, :description, :created_at], 
                  :headers => ['User name', 'Action', 'Details', 'When?']), filename: 'audits.xls') and return
      end
    end

    private

    def apply_filter
      @range_begin = params[:analytics] ? params[:analytics][:range_begin] : nil
      @range_end   = params[:analytics] ? params[:analytics][:range_end] : nil
    end

    def find_all_audits
      @audits = AuditRails::Audit.reverse_chronological.in_range(@range_begin, @range_end)
    end
  end
end
