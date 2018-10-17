# frozen_string_literal: true

Rails.application.routes.draw do
  get 'boards/index'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  root 'home#index'

  get 'home/index'
  post 'home/trigger_refresh', as: 'trigger_refresh'
  post 'home/save_trello_token', as: 'save_trello_token'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :boards, only: %i[index show] do
    resources :lists, only: %i[index show] do
      resources :cards, only: %i[index show]
    end
  end
end
