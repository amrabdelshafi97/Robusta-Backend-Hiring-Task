Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movie, controller: "movies", only: [:index, :show, :create, :destroy,:update]
  resources :celebrity, controller: "celebrities", only: [:index, :show, :create, :destroy]
  resources :news, controller: "news", only: [:index, :show, :create, :destroy]
  resources :user, controller: "users", only: [:index, :show, :create, :destroy]
  resources :genre, controller: "genres", only: [:index, :show, :create, :destroy]
  resources :award, controller: "awards", only: [:index, :show, :create, :destroy]
  resources :rate, controller: "ratings", only: [:index, :show, :create, :destroy]
end