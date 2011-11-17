FbGraphApp::Application.routes.draw do
  # Connect Site
  resource :facebook, :except => :create do
    get :callback, :to => :create
  end
  resource :dashboard, :only => :show
  
  root :to => "home#index"

end
