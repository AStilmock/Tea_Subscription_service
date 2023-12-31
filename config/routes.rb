Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index]
      resources :subscriptions, only: [:index] 
      get '/customers/:cust_id/subscriptions', to: 'customer/subscriptions#index'
      post '/customers/:cust_id/subscriptions', to: 'customer/subscriptions#create'
      patch '/customers/:cust_id/subscriptions/:sub_id', to: 'customer/subscriptions#update'
      # post /graphql, to: 'graphql#execute' 
      #RESTful vs. Non-RESTful 
    end
  end
end
