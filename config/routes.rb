Rails.application.routes.draw do
  resources :webhooks, only: [:index]
  resources :candidates
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
