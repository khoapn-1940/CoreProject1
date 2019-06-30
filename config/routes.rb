Rails.application.routes.draw do
  root "pages#home"
  get "/error", to: "errors#handle404"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/manage_users", to: "manage_users#new"
  get "/user_destroy", to: "manage_users#destroy"

  get "/view_category", to: "manage_categories#index"
  get "/new_category", to: "manage_categories#new"
  post "/new_category", to: "manage_categories#create"
  get "/delete_category", to: "manage_categories#delete"
  
  get "/new_tour", to: "manage_tours#new"
  post "/new_tour", to: "manage_tours#create"
  get "/view_tour", to: "manage_tours#view_all"
  get "/delete_tour", to: "manage_tours#destroy"

  get "/new_tour_details", to: "manage_tour_details#new"
  post "/new_tour_details", to: "manage_tour_details#create"
  get "/view_tour_details", to: "manage_tour_details#view"
  get "/delete_tour_details", to: "manage_tour_details#destroy"

  get "/new_booking_request", to: "booking_request#new"
  post "/new_booking_request", to: "booking_request#booking"
  get "/view_booking_request", to: "booking_request#view_all"
  get "/view_all_booking_request", to: "booking_request#view_all_by_admin"
  get "/delete_booking_request", to: "booking_request#destroy"

  get "/review_tour", to: "reviews#new"
  post "/review_tour", to: "reviews#create"
  get "/view_all_review", to:"reviews#view_all_reviews"
  get "/view_tour_review", to: "reviews#view_tour_reviews"
  get "/edit_my_reviews", to: "reviews#edit"
  post "/edit_my_reviews", to: "reviews#update"
  get "/delete_my_reviews", to: "reviews#destroy"
  post "/like_review", to: "reviews#like"
  post "/unlike_review", to: "reviews#unlike"

  post "/pay", to: "payments#pay"

  get "/revenue", to: "manage_revenue#index"

  get "/view_detail", to: "view_tour_details#detail"
  get "/rating_tour", to: "view_tour_details#rating"
  get "/like_a_review", to: "view_tour_details#like_review"
  get "/unlike_a_review", to: "view_tour_details#unlike_review"
  post "/comment_tour", to: "view_tour_details#comment_tour"
  post "/booking_tour", to: "view_tour_details#booking_tour"
  get "/view_my_booking", to: "self_management#view_my_booking"
  get "/delete_my_booking", to: "self_management#delete_my_booking"
  get "/view_my_review", to: "self_management#view_my_review"
  resources :users, only: [:new, :edit, :update, :create]
  resources :manage_users, only: [:new, :edit, :update]
end
