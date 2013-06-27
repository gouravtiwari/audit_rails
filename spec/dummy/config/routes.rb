Rails.application.routes.draw do

  mount AuditRails::Engine => "/audit_rails"
end
