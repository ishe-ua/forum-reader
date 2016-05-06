# coding: utf-8
# Когда последний раз данные отправлялись User -у.
#
# Поле +last_post_at+ в таблице:
# * datetime
#
module LastPostAt
  extend ActiveSupport::Concern

  included do
    after_initialize :set_default_last_post_at
    validates :last_post_at, presence: true
  end

  protected

  def set_default_last_post_at
    self.last_post_at ||= Time.zone.now
  end
end
