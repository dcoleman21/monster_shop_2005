Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :merchants
  resources :items
  resources :reviews, only: [:edit, :update, :destroy]
  resources :orders, only: [:new, :create]

  scope :merchants do
    get "/:merchant_id/items", to: "items#index"
    get "/:merchant_id/items/new", to: "items#new"
    post "/:merchant_id/items", to: "items#create"
  end

  scope :items do
    get "/:item_id/reviews/new", to: "reviews#new"
    post "/:item_id/reviews", to: "reviews#create"
  end

  scope :cart do
    post "/:item_id", to: "cart#add_item"
    get "/", to: "cart#show"
    delete "/", to: "cart#empty"
    delete "/:item_id", to: "cart#remove_item"
    patch "/:item_id/inc", to: "cart#increment_quantity"
    patch "/:item_id/dec", to: "cart#decrement_quantity"
  end

  scope :profile do
    get '/', to: 'users#show'
    get '/edit', to: 'users#edit'
    patch '/', to: 'users#update'
    get '/edit/password', to: 'users#edit'
  end

  scope :register do
    get '/', to: 'users#new'
    post '/', to: 'users#create'
  end

  scope :profile, module: :user do
    resources :orders, only: [:index, :show, :destroy]
  end

  namespace :merchant do
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    resources :items, except: :show

    scope :items do
      patch '/:id/edit', to: 'items#update_item'
    end

    scope :orders do
      get '/:id', to: 'orders#show'
      patch '/items/:id', to: 'item_orders#update'
    end
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    post '/orders/:order_id/update', to: 'orders#update'
    resources :users, only: [:index, :show]
    resources :merchants, only: [:index, :show, :update]
  end
end


#   get '/', to: 'welcome#index'
#   get '/login', to: 'sessions#new'
#   post '/login', to: 'sessions#create'
#   get '/logout', to: 'sessions#destroy'
#
#   resources :merchants
#   # get "/merchants", to: "merchants#index"
#   # get "/merchants/new", to: "merchants#new"
#   # get "/merchants/:id", to: "merchants#show"
#   # post "/merchants", to: "merchants#create"
#   # get "/merchants/:id/edit", to: "merchants#edit"
#   # patch "/merchants/:id", to: "merchants#update"
#   # delete "/merchants/:id", to: "merchants#destroy"
#   resources :items
#   # get "/items", to: "items#index"
#   # get "/items/:id", to: "items#show"
#   # get "/items/:id/edit", to: "items#edit"
#   # patch "/items/:id", to: "items#update"
#   # delete "/items/:id", to: "items#destroy"
#   resources :reviews, only: [:edit, :update, :destroy]
#   # get "/reviews/:id/edit", to: "reviews#edit"
#   # patch "/reviews/:id", to: "reviews#update"
#   # delete "/reviews/:id", to: "reviews#destroy"
#   resources :orders, only: [:new, :create]
#   # get "/orders/new", to: "orders#new"
#   # post "/orders", to: "orders#create"
#
#   scope :merchants do
#     get "/:merchant_id/items", to: "items#index"
#     # get "/:merchant_id/items/new", to: "items#new"
#     post "/:merchant/items/new", to: "items#new"
#     post "/:merchant_id/items", to: "items#create"
#   end
#
#   scope :items do
#     get "/:item_id/reviews/new", to: "reviews#new"
#     post "/:item_id/reviews", to: "reviews#create"
#   end
#
#   scope :cart do
#     post "/:item_id", to: "cart#add_item"
#     get "/", to: "cart#show"
#     delete "/", to: "cart#empty"
#     delete "/:item_id", to: "cart#remove_item"
#     patch "/:item_id/inc", to: "cart#increment_quantity"
#     patch "/:item_id/dec", to: "cart#decrement_quantity"
#   end
#
#   scope :profile do
#     get '/', to: 'users#show'
#     get '/edit', to: 'users#edit'
#     patch '/', to: 'users#update'
#     get '/edit/password', to: 'users#edit'
#   end
#
#   scope :register do
#     get '/', to: 'users#new'
#     post '/', to: 'users#create'
#   end
#
#   scope :profile, module: :user do
#     resources :orders, only: [:index, :show, :destroy]
#     # get "/profile/orders/:id", to: "user/orders#show"
#     # get '/profile/orders', to: 'user/orders#index'
#     # delete '/profile/orders/:id', to: 'user/orders#destroy'
#   end
#
#   namespace :merchant do
#     get '/', to: 'dashboard#index'
#     get '/dashboard', to: 'dashboard#index'
#     resources :items, except: :show
#
#     scope :items do
#       patch '/:id/edit', to: 'items#update_item'
#     end
#     # get '/items', to: 'items#index'
#     # get '/items/new', to: 'items#new'
#     # post '/items/new', to: 'items#create'
#     # patch '/items/:id', to: 'items#update'
#     # delete '/items/:id', to: 'items#destroy'
#     # get '/items/:id/edit', to: 'items#edit'
#
#     scope :orders do
#       get '/:id', to: 'orders#show'
#       patch '/items/:id', to: 'item_orders#update'
#     end
#   end
#
#   namespace :admin do
#     get '/', to: 'dashboard#index'
#     get '/dashboard', to: 'dashboard#index'
#     post '/orders/:order_id/update', to: 'orders#update'
#     resources :users, only: [:index, :show]
#     # get '/users', to: 'users#index'
#     # get '/users/:user_id', to: 'users#show'
#     resources :merchants, only: [:index, :show, :update]
#     # get '/merchants/:id', to: 'merchants#show'
#     # get '/merchants', to: 'merchants#index'
#     # patch '/merchants/:id', to: 'merchants#update'
#   end
# end
