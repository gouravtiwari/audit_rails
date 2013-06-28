require 'rubygems'
require 'to_xls'

module AuditRails
  class Engine < ::Rails::Engine
    isolate_namespace AuditRails

    initializer "audit_rails.load_helpers" do |app|
      ActionController::Base.send :include, AuditRails::AuditsHelper
    end
    
    config.generators do |g|
      g.test_framework      :rspec
      g.assets false
      g.helper false
    end

  end
end
