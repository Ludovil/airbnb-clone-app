Rails.application.routes.draw do

  resource :profile, only: [:show, :edit, :update]

  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/show'
  get 'bookings/destroy'
  devise_for :users

  root to: "pages#home"


  resources :apartments, only: [:index, :new, :create, :show] do
    resources :bookings, only: [:new, :create, :show, :destroy]
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
