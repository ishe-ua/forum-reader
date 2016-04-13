# coding: utf-8
# Пароль аккаунта.
#
# Поле +password_digest+ в таблице:
# * строка
# * непустое
#
module Password
  extend ActiveSupport::Concern

  ## Минимальная длинна.
  MIN_PASSWORD = 5

  ## Максимальная длинна.
  MAX_PASSWORD = 155

  included do
    has_secure_password

    validates :password,
              presence: true,

              length: { in: MIN_PASSWORD..MAX_PASSWORD },
              on: :create
  end

  class_methods do
    ## Генерим случайный пароль и возвращаем как строку.
    def gen_random_password
      Tokenizer.random_string()
    end
  end
end
