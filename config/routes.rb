Rails.application.routes.draw do
  resources :blogs
  get 'admin_panel', to: 'admin_panel#index'

  #
  # Admin Section
  #
  post 'admin_create_video', to: "admin_panel#create_video"
  post 'admin_remove_video', to: "admin_panel#remove_video"
  post 'admin_create_user', to: "admin_panel#create_user"
  post 'admin_remove_user', to: "admin_panel#remove_user"
  post 'admin_add_admin_user', to: "admin_panel#create_admin_user"
  get 'admin_add_user', to: "admin_panel#create_video"
  get 'admin_workouts', to: "admin_panel#admin_workouts"
  get 'admin_users_mapping', to: "admin_panel#admin_users_mapping"
  get 'admin_user_connection', to: "admin_panel#admin_user_connection"
  get 'admin_add_videos', to: "admin_panel#admin_add_videos"
  get 'admin_paypal_transactions', to: "admin_panel#admin_paypal_transactions"
  get 'admin_show_users', to: "admin_panel#admin_show_users"
  get 'admin_blogs', to: "admin_panel#admin_blogs"
  get 'seo_dynamic_data', to: "admin_panel#seo_dynamic_data"
  resources :free_videos

  resources :media
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :workout_sets
  get 'tutorials', to: "tutorials#index"
  #
  # DEVICE
  #
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  #
  # My Videos Section
  #
  get 'my_videos', to: "my_videos#index"
  get 'my_videos/:id', to: "my_videos#show"
  get 'contact_us', to: "contacts#index"

  #
  # PayPal Section
  #
  get 'payment_details', to: "transaction#details"
  get 'transactions/:id', to: "transaction#create_payment"
  get 'payment_execute', to: "transaction#payment_execute"
  get 'webhooks', to: "webhooks#index"
  post 'webhooks', to: "webhooks#get_event"

  #
  # About
  #
  get 'about', to: "about#index"
end
