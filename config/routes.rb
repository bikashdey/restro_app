Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  resources :dishes do 
    post :create_reviews, on: :member
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "restaurants#index"
  resources :restaurants do 
    collection do
      get :search_restro
    end
    patch :update_restro_status, on: :member
    post :create_reviews, on: :member
  end
end
