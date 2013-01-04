require 'rubygems'
require 'to_xls'

module AuditRails
  class Engine < ::Rails::Engine
    isolate_namespace AuditRails
  end
end
