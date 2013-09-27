AuditRails::Engine.routes.draw do
  resources :audits, :only => [:create, :index] do
    collection do
      get :analytics
      post :filter
    end
  end
end
