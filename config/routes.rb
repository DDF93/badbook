Rails.application.routes.draw do
  resources :books do
    resources :sessions, only: [:show] do
      resources :attendees, only: [:create]
      post 'join', on: :member
      post 'rsvp', on: :member  # Define route for RSVP action
    end
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:edit, :update, :show, :destroy]
  resources :topics
  resources :bookshelf_books
  resources :bookshelves
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
