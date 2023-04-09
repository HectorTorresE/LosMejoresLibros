Rails.application.routes.draw do
  get 'sales/create'
  root 'pages#home'
  resources :books
  resources :sales do
    member do
      patch :pay_author
      patch :set_autopay
    end
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
