XnotY::Application.routes.draw do
  resources :users

  resources :events

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products


  resource :welcome, :only => [:index]
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  resource :facebook, except: :new do
    get :callback, to: :create
  end

end
