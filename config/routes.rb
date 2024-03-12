Rails.application.routes.draw do
  resources :books do
    resources :sessions, only: [:show] do
      resources :attendees, only: [:create]
      post 'join', on: :member
    end
  end
  resources :topics
  resources :bookshelf_books
  resources :bookshelves
  resources :reviews
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
