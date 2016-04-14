# coding: utf-8
# Генератор токенов.
#
module Tokenizer
  ## Размер токена по дефолту.
  DEFAULT_SIZE = 24

  ## Выдать токен (строку случайных чисел) заданного размера.
  def self.random_string(size = DEFAULT_SIZE)
    chars = ('a'..'z').to_a.shuffle
    nums = (0..9).to_a.shuffle

    ar = (chars + nums).shuffle
    1.upto(size).map { ar.sample }.join
  end
end
