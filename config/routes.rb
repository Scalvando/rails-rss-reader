# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root 'entries#index'

  resources :feeds do
    member do
      get :sync
      get :saved
    end
  end

  resources :entries do
    member do
      post :save
    end
    collection do
      get :sync
      get :saved
    end
  end

  get '*path', to: 'errors#not_found', via: :all
end
