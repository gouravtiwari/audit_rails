require 'rails'

module AuditRails
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "This generator adds routes to routes.rb"
      source_root File.expand_path('../../../../../config', __FILE__)

      def add_routes
        route "mount AuditRails::Engine, at: \"/audit_rails\""
      end
    end
  end
end