Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "books#index"
    get "/home", to: "books#index"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/search", to: "search#search"
    get "/cart", to: "cart_item#index"
    get "/addUser", to: "users#newUser"
    post "/addUser", to: "users#create"
    get "/addbook", to: "books#new"
    post "/addbook", to: "books#create"
  end

  resources :users

  resources :categories, only: [:index] do
    resources :books, only: [:index, :show, :new, :update]
  end

  resources :cart_item, path: "/cart/items"
end
