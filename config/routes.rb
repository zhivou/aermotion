Rails.application.routes.draw do
  get 'admin_panel', to: 'admin_panel#index'
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
