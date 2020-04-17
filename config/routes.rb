Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  root to: 'items#index'

  # Web

  resources :items
  get '/filter_items' => 'items#from_tag', as: 'filter_items'
  get '/pending_to_filter' => 'items#pending_to_filter', as: 'pending_to_filter'

  # API

  namespace :api do
    get 'most_used_tags' => 'tags#most_used'
    resources :items
    get 'credentials/me', to: 'credentials#me'

  end
end
