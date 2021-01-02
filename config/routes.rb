Rails.application.routes.draw do
  root 'sessions#welcome'

  resources :movies, controller: "movies", only: [:index, :show, :create, :destroy, :update] do
    member do
      post :rate, action: :addMovieRate
      post :watchlist, action: :addMovieToUserWatchlist
      post :comment, action: :addUserCommentToMovie
    end
    collection do
      get :search, action: :search
    end
  end
  resources :celebrities, controller: "celebrities", only: [:index, :show, :create, :destroy, :update] do
    collection do
      get :search, action: :search
    end
  end
  resources :news, controller: "news", only: [:index, :show, :create, :destroy, :update] do
    collection do
      get :search, action: :search
    end
  end
  resources :users, controller: "users", only: [:index, :show, :create, :destroy, :update] do
    member do
      get :watchlist, action: :getUserMovieWatchList
    end
  end
  resources :genres, controller: "genres", only: [:index, :show, :create, :destroy, :update]
  resources :awards, controller: "awards", only: [:index, :show, :create, :destroy, :update]
  resources :rates, controller: "rates", only: [:index, :show, :create, :destroy, :update]
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end