Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


############## ORIGINAL ROUTES ##############
  # resources :books, only: [:index, :show, :new, :create, :destroy] do
  #   resources :reviews, only: [:new, :create, :destroy]
  # end

  # resources :authors, only: [:show, :destroy]
  #
  # resources :users, only: [:show]
  #
  # get '/', to: 'welcome#index'



  ############## WITHOUT USING RESOURCES ##############

  post   '/books/:book_id/reviews', to: 'reviews#create', as: 'book_reviews'
  get    '/books/:book_id/reviews/new', to: 'reviews#new', as: 'new_book_review'
  delete '/books/:book_id/reviews/:id', to: 'reviews#destroy', as: 'book_review'

  get '/books', to: 'books#index'
  post '/books', to: 'books#create'
  get '/books/new', to: 'books#new', as: 'new_book'
  get '/books/:id', to: 'books#show', as: 'book'
  delete '/books/:id', to: 'books#destroy'

  get '/authors/:id', to: 'authors#show', as: 'author'
  delete 'authors/:id', to: 'authors#destroy'

  get '/users/:id', to: 'users#show', as: 'user'

  get '/', to: 'welcome#index'


end
