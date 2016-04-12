# coding: utf-8
# Никнейм.
#
# Поле +nick+ в таблице:
# * строка
# * unique-индекс
#
module Nick
  extend ActiveSupport::Concern

  ## Допустимые символы.
  VALID_NICK = /[a-z0-9]+/ # TODO: надо правильный regexp, это левый

  ## Минимальная длинна.
  MIN_NICK = 4

  ## Максимальная длинна.
  MAX_NICK = 44

  included do
    before_validation :downcase_nick, if: :nick_changed?

    validates :nick,
              uniqueness: true,

              format: { with: VALID_NICK },
              length: { in: MIN_NICK..MAX_NICK }

    protected
  end

  ## Значение в нижний регистр.
  def downcase_nick
    nick.downcase!
  end
end
