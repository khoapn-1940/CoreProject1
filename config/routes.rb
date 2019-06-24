Rails.application.routes.draw do
  root "sessions#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/manage_users", to: "manage_users#new"

  get "/view_category", to: "manage_categories#index"
  get "/new_category", to: "manage_categories#new"
  post "/new_category", to: "manage_categories#create"
  get "/delete_category", to: "manage_categories#delete"
  
  get "/new_tour", to: "manage_tours#new"
  post "/new_tour", to: "manage_tours#create"
  get "/view_tour", to: "manage_tours#view_all"

  get "/new_tour_details", to: "manage_tour_details#new"
  post "/new_tour_details", to: "manage_tour_details#create"
  get "/view_tour_details", to: "manage_tour_details#view"
  get "/delete_tour_details", to: "manage_tour_details#destroy"

  get "/new_booking_request", to: "booking_request#new"
  post "/new_booking_request", to: "booking_request#booking"
  get "/view_booking_request", to: "booking_request#view_all"
  get "/view_all_booking_request", to: "booking_request#view_all_by_admin"
  get "/delete_booking_request", to: "booking_request#destroy"
  resources :users, only: [:new, :edit, :update, :create]
  resources :manage_users, only: [:new, :edit, :update]
end
