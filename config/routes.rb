Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index]
      resources :subscriptions, only: [:index] 
      post '/customers/:id/subscriptions', to: 'customer/subscriptions#create'
    end
  end
end
