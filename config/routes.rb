Rails.application.routes.draw do
  resources :movie, controller: "movies", only: [:index, :show, :create, :destroy, :update] do
    member do
      post :rate, action: :addMovieRate
      post :watchlist, action: :addMovieToUserWatchlist
      post :comment, action: :addUserCommentToMovie
    end
    collection do
      get :search, action: :search
    end
  end
  resources :celebrity, controller: "celebrities", only: [:index, :show, :create, :destroy, :update] do
    collection do
      get :search, action: :search
    end
  end
  resources :news, controller: "news", only: [:index, :show, :create, :destroy, :update] do
    collection do
      get :search, action: :search
    end
  end
  resources :user, controller: "users", only: [:index, :show, :create, :destroy, :update] do
    collection do
      post :login, action: :userLogin
    end
    member do
      get :watchlist, action: :getUserMovieWatchList
    end
  end
  resources :genre, controller: "genres", only: [:index, :show, :create, :destroy, :update]
  resources :award, controller: "awards", only: [:index, :show, :create, :destroy, :update]
  resources :rate, controller: "rates", only: [:index, :show, :create, :destroy, :update]
end