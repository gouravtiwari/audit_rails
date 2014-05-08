module AuditRails
  module AuditsHelper
    def add_to_audit(action_name=nil, controller_name=nil, user_name=nil, description=nil)
      if (action_name == "login" && 
              AuditRails::Audit.no_audit_entry_for_today?(action_name, user_name)) || 
        action_name != "login"
          AuditRails::Audit.create(action: get_action(action_name), 
            controller: controller_name || request.params[:controller], 
            user_name: user_name, 
            description: description,
            ip_address: request.remote_ip.to_s)
      end
    end

    def get_action(action_name)
      action_name || request.params[:action]
    end

    def active?(action_name)
      controller.action_name == action_name
    end

    def active_class(action_name)
      active?(action_name) ? 'active' : ''
    end

    def page_visits_by_user(user)
      JSON.parse(@analysis[:per_user_by_page_views])[user].to_json
    end

    def percentage_share(user, count, total)
      "#{(100.0 * count/total).round(1)}%"
    end
  end
end
