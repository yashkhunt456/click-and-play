Rails.application.routes.draw do
  get "feedbacks/index"
  get "feedbacks/new"
  get "feedbacks/edit"
 
  namespace :admin do
    root "dashboard#index"
    resources :dashboard, only: [:index] do
      member do
        delete 'destroy_user/:id', to: 'dashboard#destroy', as: :destroy_user
        delete 'destroy_boxhouse/:id', to: 'dashboard#destroy', as: :destroy_boxhouse
      end
    end
    resources :users, only: [:index, :show, :destroy]
    resources :boxhouses, only: [:index, :show, :destroy]
  end
  root "boxhouses#index"
  devise_for :users, sign_out_via: [:get]
  # resources :bookings, only: [:index, :show, :edit, :update, :destroy]
  resources :boxhouses do
    resources :boxes do
      resources :slots, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      resources :bookings, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
        resource :payment, only: [:new, :create]
        resources :feedbacks, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
