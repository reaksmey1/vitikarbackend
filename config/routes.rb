Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    post 'signup', to: 'registrations#create'
    post 'login', to: 'sessions#create'
    
    resources :favorites

    resources :events do
      post "favorite", to: "favorites#create"
      delete "unfavorite", to: "favorites#destroy"
    end
  end
end
