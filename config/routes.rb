AuditRails::Engine.routes.draw do
  resources :audits, :only => [:create, :index]
end
