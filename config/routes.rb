Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
    #users 
    devise_for :users, controllers: { 
        confirmations: 'users/confirmations',
        passwords: 'users/passwords',
        registrations: 'users/registrations',
        sessions: 'users/sessions',
        unlocks: 'users/unlocks'
    }

    as :user do  
        get 'users/sign_out' => 'users/sessions#destroy'
        get 'users/settings' => 'users#edit'
        get 'users/email_subscribers' => 'users#email_subscribers'
    end

    resources :users, only: [:index, :show] do
        resources :collections
        resources :collection_resources 
        resources :favorites, only: [:index, :create, :destroy]
    end

    get 'admin' => 'control_panel#index', :as => :admin
    resources :control_panel, only: [:index] 


    #resources & tags  
    resources :resources 
    resources :tags, only: [:create]
    resources :resource_tags, only: [:create, :destroy]

    #reviews 
    resources :reviews

    #categories
    resources :categories

    #welcome
    resources :welcome 

    root to: "welcome#index"

end
