Rails.application.routes.draw do
  devise_for :users
  root to: "mariages#index"
  resources :mariages do
    resources :comments, only: :create
  end
end
