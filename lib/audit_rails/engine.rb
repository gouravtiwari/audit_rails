require 'rubygems'
require 'to_xls'

module AuditRails
  class Engine < ::Rails::Engine
    isolate_namespace AuditRails
    
    config.generators do |g|
      g.test_framework      :rspec
      g.assets false
      g.helper false
    end

  end
end
