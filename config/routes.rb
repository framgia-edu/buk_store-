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
    get "/books", to: "books#index"
    get "/show", to: "static_pages#show"
    post "/cart_items", to: "cart_items#create"
    delete "/cart", to: "carts#destroy"
    get "/cart", to: "carts#index"

    resources :users
    resources :account_activations, only: [:edit]
    resources :categories, only: [:index] do
      resources :books, only: [:index, :show]
    end
  end
  post "/cart_items/add_quantity", to: "cart_items#add_quantity"
  post "/cart_items/reduce", to: "cart_items#reduce_quantity"
  delete "/cart_items/delete", to: "cart_items#destroy"
  resources :orders

end
