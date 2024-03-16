Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books do
    resources :sessions, only: [:show] do
      resources :attendees, only: [:create]
      post 'join', on: :member
      post 'rsvp', on: :member  # Define route for RSVP action
      delete 'rsvp', to: 'sessions#revoke_rsvp'
    end
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:edit, :update, :show, :destroy]
  resources :sessions, only: [:show, :index] do
    resources :attendees, only: [:create]
    post 'join', on: :member
  end
  post '/add_book_to_bookshelf', to: 'bookshelves#add_book_to_bookshelf'
  resources :topics
  resources :bookshelf_books
  resources :bookshelves
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
