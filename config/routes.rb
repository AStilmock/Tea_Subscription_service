Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index]
      resources :subscriptions, only: [:index] 
      get "/customers/:id/subscriptions", to: "customer_subscriptions#index"
      post "/customers/:id/subscriptions/:id", to: "customer_subscriptions#create"
      patch "/customers/:id/subscriptions/:id", to: "customer_subscriptions#update"
      delete "/customers/:id/subscriptions/:id", to: "customer_subscriptions#destroy"
    end
  end
end
