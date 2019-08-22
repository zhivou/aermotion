Rails.application.routes.draw do
  get 'admin_panel', to: 'admin_panel#index'
  # get 'admin_new_video', to: "admin_panel#new_video"
  post 'admin_create_video', to: "admin_panel#create_video"
  post 'admin_remove_video', to: "admin_panel#remove_video"

  get 'admin_add_user', to: "admin_panel#create_video"
  resources :media
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :workout_sets
  #
  # DEVICE
  #
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
end
