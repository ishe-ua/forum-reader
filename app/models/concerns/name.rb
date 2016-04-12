# coding: utf-8
# Название.
#
# Поле +name+ в таблице:
# * строка
# * непустое
#
module Name
  extend ActiveSupport::Concern

  ## Максимальная длинна.
  MAX_NAME = 256

  included do
    validates :name,
              presence: true,

              length: { maximum: MAX_NAME }

    before_validation :trim_name
  end

  protected

  ## Укоротить длинну если надо.
  def trim_name
    self.name = name[0..(MAX_NAME - 1)] if name.present?
  end
end
