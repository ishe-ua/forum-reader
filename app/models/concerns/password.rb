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
    ## Генерим случайный  и возвращаем как строку.
    def gen_random_password
      length = MIN_PASSWORD * 4

      s1 = ('A'..'Z').to_a.shuffle
      s2 = ('a'..'z').to_a.shuffle
      s3 = (0..9)    .to_a.shuffle

      array = (s1 + s2 + s3).shuffle
      array[0..(length - 1)].join
    end
  end
end
