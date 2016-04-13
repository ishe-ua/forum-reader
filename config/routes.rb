# coding: utf-8
Rails.application.routes.draw do
  root 'pages#home'

  ###
  # Статические страницы.
  #

  controller :pages do
    get 'pages/home'
    get 'pages/help'
    get 'pages/info'
    get 'pages/data'
    get 'pages/settings'
  end
end
