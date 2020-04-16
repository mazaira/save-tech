Rails.application.routes.draw do
  use_doorkeeper
  Devise.setup do |config|
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  end

  root to: 'items#index'

  resources :items
  get '/filter_items' => 'items#from_tag', as: 'filter_items'
  get '/pending_to_filter' => 'items#pending_to_filter', as: 'pending_to_filter'

  namespace :api do
    resources :items
    get 'credentials/me', to: 'credentials#me'

  end
end
