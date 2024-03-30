Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  root to: "pages#home"
  get '/my_library', to: 'pages#my_library'
  get '/search', to: 'search#index'

  resources :books do
    resources :sessions, only: [:show, :index] do
      resources :attendees, only: [:create]
      resources :agendas do
        member do
          post 'upvote'
          post 'downvote'
        end
      end
      post 'join', on: :member
      post 'rsvp', on: :member
      delete 'rsvp', to: 'sessions#revoke_rsvp'
    end
    resources :reviews, only: [:new, :create]
  end

  # Add :create here to handle session creation
  resources :sessions, only: [:show, :index, :create] do
    resources :attendees, only: [:create]
    post 'join', on: :member
  end

  resources :reviews, only: [:edit, :update, :show, :destroy]

  post '/add_book_to_bookshelf', to: 'bookshelves#add_book_to_bookshelf'
  post '/remove_book_from_bookshelf', to: 'bookshelves#remove_book_from_bookshelf'
  post '/create_meeting', to: 'meetings#create_meeting'
  post '/initiate_call', to: 'messages#initiate_call'



  resources :topics
  resources :bookshelf_books
  resources :bookshelves
  resources :chatrooms, only: :show

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
