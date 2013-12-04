AuditRails::Engine.routes.draw do
  resources :audits, :only => [:create] do
    collection do
      get :analytics
    end
  end
end
