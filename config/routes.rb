Rails.application.routes.draw do
  devise_for :users
  root to: "mariages#index"
  resources :users, only: :show
  resources :mariages do
    resources :comments, only: :create
  end
end
