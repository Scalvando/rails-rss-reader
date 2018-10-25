# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  resources :feeds do
    member do
      get :sync
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
