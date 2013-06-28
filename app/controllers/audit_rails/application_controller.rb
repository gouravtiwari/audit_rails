module AuditRails
  class ApplicationController < ActionController::Base

    include AuditRails::AuditsHelper
  end
end
