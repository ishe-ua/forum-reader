# coding: utf-8
Rails.application.routes.draw do
  root 'pages#home'

  ###
  # Статические страницы
  #

  controller :pages do
    get 'home'
    get 'help'
    get 'info'
    get 'data'
    get 'settings'
  end

  ###
  #
  #

  get 'register', to: redirect('accounts/new'),  as: :register
  get 'login',    to: redirect('sessions/new'),  as: :login
  get 'logout',   to: 'sessions#destroy',        as: :logout

  resources :contacts, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'locale/change/:lang', to: 'locale#change', as: :change_locale
end
