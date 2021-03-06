XnotY::Application.routes.draw do
  resources :invites, :only => [:destroy, :show]

  resources :responses

  resources :suggestions do
    resources :responses
  end

  resources :users
  
  resources :sms, only: [] do
    collection do
      post :record
    end
  end

  resources :events do
    member do
      post :join
    end

    resources :invites
    resources :suggestions
  end

  resources :geocode, :only => [] do
    collection do
      get :resolve
    end
  end

  resource :welcome, :only => [:index]

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  resource :facebook, except: :new do
    get :callback, to: :create
  end

end
