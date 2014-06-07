Rails.application.routes.draw do
  get "about" => 'static_pages#about'
  get "home" => 'static_pages#home'
  get 'signup' => 'users#new'
  root to: 'static_pages#home'
  resources :users
end
