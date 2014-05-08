require_dependency "audit_rails/application_controller"

module AuditRails
  class AuditsController < ApplicationController
    before_filter :apply_filter, except: [:create]

    def create
      add_to_audit("visit-site", "xyz", "Fake User")
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end

    def analytics
      @analysis = AuditRails::Audit.analysis(@range_begin, @range_end)
      @no_audits = AuditRails::Audit.count == 0

      if params[:commit] == "DOWNLOAD REPORT"
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
