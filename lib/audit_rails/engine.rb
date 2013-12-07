require 'rubygems'
require 'to_xls'

module AuditRails
  class Engine < ::Rails::Engine
    isolate_namespace AuditRails

    initializer :append_dependent_assets_path, :group => :all do |app| 
      require 'sleek_charts'
      engine_root = SleekCharts::Engine.root
      app.config.assets.paths.push(engine_root + 'app/assets/javascripts')
      app.config.assets.paths.push(engine_root + 'app/assets/stylesheets')
    end

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
