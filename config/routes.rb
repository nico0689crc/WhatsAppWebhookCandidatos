Rails.application.routes.draw do
  resources :webhooks, only: [:index, :create] do
    post 'initial_message', to: 'webhooks#initial_message', on: :collection
  end
  resources :candidates
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
