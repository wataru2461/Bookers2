Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get "/home/about" => "home#about", as: "about"
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] 
  resources :users, only: [:index, :show, :edit, :update]
end