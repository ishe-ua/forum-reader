Rails.application.routes.draw do
  root 'pages#home'
  mount BeanstalkdView::Server, at: '/beanstalkd'

  ###
  # Static pages
  #

  controller :pages do
    get 'home'
    get 'help'
    get 'info'
    get 'data'
  end

  ###
  # Account
  #

  get 'register', to: redirect('accounts/new'),  as: :register
  get 'login',    to: redirect('sessions/new'),  as: :login
  get 'logout',   to: 'sessions#destroy',        as: :logout

  resources :accounts, except: [:index, :show]

  get 'accounts/confirm_email/:token' =>
      'accounts#confirm_email', as: :confirm_email

  get 'accounts/confirm_jabber/:token' =>
      'accounts#confirm_jabber', as: :confirm_jabber

  get 'accounts/repeat_email_confirmation' =>
      'accounts#repeat_email_confirmation', as: :repeat_email_confirmation

  get 'accounts/repeat_jabber_confirmation' =>
      'accounts#repeat_jabber_confirmation', as: :repeat_jabber_confirmation

  match 'accounts/reset_password' =>
        'accounts#reset_password', via: [:get, :post], as: :reset_password

  ###
  # Others
  #

  resources :contacts, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'locale/change/:lang', to: 'locale#change', as: :change_locale

  resources :forums, except: :show do
    member do
      patch :move_up
      patch :move_down
    end
  end

  resources :letters, except: :show do
    member do
      patch :move_up
      patch :move_down
    end
  end

  resources :letter_items, except: :show do
    member do
      patch :move_up
      patch :move_down
    end
  end

  resources :reader_sets, as: :reader, only: [] do
    member do
      patch :change_status
    end
  end

  resources :mailer_sets, as: :mailer, only: [] do
    member do
      patch :change_status
    end
  end

  ###
  #
  #
end
