Rails.application.routes.draw do
  resources :plans, only: [ :index ]
  resources :subscriptions, only: [ :index, :create ]
  devise_for :users

  root "home#index"

  resources :plans, only: :index

  resources :subscriptions, only: [ :index, :create ] do
    resources :usage_entries, only: :create
  end

  resources :invitations, only: [ :new, :create ]

  match "/invitations/:token/accept",
        to: "invitations#accept",
        via: [ :get, :post ],
        as: :accept_invitation

  root "home#index"
<<<<<<< HEAD

  namespace :admin do
    get "features/index"
    get "features/new"
    get "features/edit"
    get "features/show"
    root "dashboard#index"

    resources :features
    resources :plans do
      resources :plan_features, only: [ :create, :destroy ]
    end
    resources :subscriptions, only: [ :index, :show ]
  end

  resource :payment_authorization, only: [ :show, :create ] do
    get :confirm
  end

  namespace :admin do
    root "dashboard#index"

    resources :features

    resources :plans do
      resources :plan_features, only: [ :create, :destroy ]
    end

    resources :subscriptions, only: [ :index, :show ]
  end

  namespace :admin do
    root "dashboard#index"

    resources :features

    resources :plans do
      resources :plan_features, only: [ :create, :destroy ]
    end

    resources :subscriptions, only: [ :index, :show ]
  end
=======
>>>>>>> ea7710a (feat (buyer & stripe): Implement buyer subscriptions and Stripe payment authorizations)

  namespace :admin do
    get "features/index"
    get "features/new"
    get "features/edit"
    get "features/show"
    root "dashboard#index"

    resources :features
    resources :plans do
      resources :plan_features, only: [ :create, :destroy ]
    end
    resources :subscriptions, only: [ :index, :show ]
  end

  resource :payment_authorization, only: [ :show, :create ] do
    get :confirm
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
