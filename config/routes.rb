Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: "mariages#index"
  get 'searches/index', to: 'searches#index'
  get 'searches/search', to: 'searches#search'
  resources :users, only: :show
  resources :mariages do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
end
