Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "books#index"
    get "/home", to: "books#index"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/search", to: "search#search"

    resources :users

  end

  resources :categories, only: [:index] do
    resources :books, only: [:index, :show]
  end

  get "/cart", to: "cart_item#index"
  resources :cart_item, path: "/cart/items"
end
