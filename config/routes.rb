Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'items#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # Web

  resources :items
  get '/filter_items' => 'items#from_tag', as: 'filter_items'
  get '/pending_to_filter' => 'items#pending_to_filter', as: 'pending_to_filter'

  # API

  namespace :api do
    get 'credentials/me', to: 'credentials#me'

    resources :items
    resources :tags
    get 'most_used_tags' => 'tags#most_used'


  end
end
