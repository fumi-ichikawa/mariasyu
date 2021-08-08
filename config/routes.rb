Rails.application.routes.draw do
  devise_for :users
 root to: "mariages#index"
 resources :mariages,only: [:index, :new, :create]
end
