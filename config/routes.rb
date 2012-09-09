XnotY::Application.routes.draw do
  resources :responses

  resources :suggestions

  resources :users

  resources :events

  resource :welcome, :only => [:index]

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  resource :facebook, except: :new do
    get :callback, to: :create
  end

end
