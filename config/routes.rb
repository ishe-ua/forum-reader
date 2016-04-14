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

  resources :contacts, only: [:new, :create]

  get 'locale/change/:lang', to: 'locale#change', as: :change_locale
end
