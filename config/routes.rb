Rails.application.routes.draw do
  
  root to: "books#index"

  resources :books
  resources :categories
  resources :users
  resources :authors

  resources :sessions, only: [:new, :create]
  post '/sessions/destroy' => 'sessions#destroy'
  post '/books/:id/add_to_fav' => 'books#add_to_fav'
  delete '/books/:id/remove_from_fav' => 'books#remove_from_fav'
  get '/user_favorites' => 'users#favorite_books'

  get '/book_reports' => "books#book_reports"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
