Rails.application.routes.draw do
  resources :books do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:edit, :update, :show, :destroy]
  resources :sessions, only: [:show] do
<<<<<<< HEAD
      resources :attendees, only: [:create]
      post 'join', on: :member
=======
    resources :attendees, only: [:create]
    post 'join', on: :member
>>>>>>> 83cfa35aa8459673cb2fda3befb6bdcf1fb9ee78
  end
  resources :topics
  resources :bookshelf_books
  resources :bookshelves
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
