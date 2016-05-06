# Field +nick+ in table:
# * string
# * unique
#
module Nick
  extend ActiveSupport::Concern

  VALID_NICK = /\A[a-z0-9\-\.]+\z/

  MIN_NICK = 4

  MAX_NICK = 44

  included do
    before_validation :downcase_nick, if: :nick_changed?

    validates :nick,

              presence: true,
              uniqueness: true,

              format: { with: VALID_NICK },
              length: { in: MIN_NICK..MAX_NICK }
  end

  protected

  def downcase_nick
    nick.downcase!
  end
end
