Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do

  root "pages#home"
  get "/error", to: "errors#handle404"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/search", to: "pages#search"
  # get "/manage_users", to: "manage_users#new"
  # get "/user_destroy", to: "manage_users#destroy"

  # get "/view_category", to: "manage_categories#index"
  # get "/new_category", to: "manage_categories#new"
  # post "/new_category", to: "manage_categories#create"
  # get "/delete_category", to: "manage_categories#delete"
  
  # get "/new_tour", to: "manage_tours#new"
  # post "/new_tour", to: "manage_tours#create"
  # get "/view_tour", to: "manage_tours#view_all"
  # get "/delete_tour", to: "manage_tours#destroy"

  # get "/new_tour_details", to: "manage_tour_details#new"
  # post "/new_tour_details", to: "manage_tour_details#create"
  # get "/view_tour_details", to: "manage_tour_details#view"
  # get "/delete_tour_details", to: "manage_tour_details#destroy"

  # get "/new_booking_request", to: "booking_request#new"
  # post "/new_booking_request", to: "booking_request#booking"
  # get "/view_booking_request", to: "booking_request#view_all"
  # get "/view_all_booking_request", to: "booking_request#view_all_by_admin"
  # get "/delete_booking_request", to: "booking_request#destroy"

  # get "/review_tour", to: "reviews#new"
  # post "/review_tour", to: "reviews#create"
  # get "/view_all_review", to:"reviews#view_all_reviews"
  # get "/view_tour_review", to: "reviews#view_tour_reviews"
  # get "/edit_my_reviews", to: "reviews#edit"
  # post "/edit_my_reviews", to: "reviews#update"
  # get "/delete_my_reviews", to: "reviews#destroy"
  # post "/like_review", to: "reviews#like"
  # post "/unlike_review", to: "reviews#unlike"

  # post "/pay", to: "payments#pay"

  # get "/revenue", to: "manage_revenue#index"

  get "/view_my_booking", to: "self_management#view_my_booking"
  get "/view_my_review", to: "self_management#view_my_review"
  get "/view_my_information", to: "self_management#view_my_information"
  get "/view_other_user_information", to: "self_management#view_other_user_information"
  resources :self_management, only: [:edit, :update]
  resources :tour_details, only: [:new]
  resources :ratings, only: [:new]
  resources :bookings, only: [:new, :destroy]
  resources :likes, only: [:new, :destroy]
  resources :comments, only: [:new, :destroy]
  resources :users, only: [:new, :edit, :update, :create]
  resources :manage_users, only: [:new, :edit, :update]
  resources :payments, only: [:create]

  namespace :admin do
    resources :users, except: []
    resources :reviews, except: []
    resources :categories, except: []
    resources :tours, except: []
    resources :tour_details, except: []
    resources :bookings, except: []
    resources :payments, only: [:index]
  end
end
end
