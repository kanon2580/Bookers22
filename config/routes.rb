Rails.application.routes.draw do

  # homes
  root 'homes#top'
  get 'homes/about' => 'homes#about'

  # books
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]

  # users
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
