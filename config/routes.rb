require 'sidekiq/web'
Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  get 'sales/create'
  root 'pages#home'
  resources :books do
    member do
      patch :refund
    end
  end
  resources :sales do
    member do
      patch :pay_author
      post :set_autopay
    end
  end
  # patch 'set_autopay/:id/:days', to: 'sales#set_autopay', as: :set_autopay_user
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
