AuditRails::Engine.routes.draw do
  resources :audits, :only => [:create, :index] do
    collection do
      get :analytics
    end
  end
end
