Rails.application.routes.draw do
  resources :gyms, only: [:index, :show, :destroy, :update, :create]
  resources :clients, only: [:index, :show, :destroy, :update, :create]
  resources :memberships, only: [:index, :show, :destroy, :update, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
