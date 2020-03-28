Rails.application.routes.draw do
  Devise.setup do |config|
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  end

  root to: 'items#index'

  resources :items
  get '/filter_items' => 'items#from_tag', as: 'filter_items'

  namespace :api do
    resources :items
  end
end
