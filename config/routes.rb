FbGraphApp::Application.routes.draw do
  # Canvas App
  resource :canvas, :only => [:show, :create]
  
  # Connect Site
  resource :facebook, :except => :create do
    get :callback, :to => :create
  end
  resource :dashboard, :only => :show
  
  root :to => "home#index"

end
