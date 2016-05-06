# Send to +email+ or +jabber+.
#
# Field +target+ in table:
# * integer
#
module Target
  extend ActiveSupport::Concern

  SUPPORTED_TARGETS = %w(email jabber).freeze

  included do
    enum target: SUPPORTED_TARGETS

    after_initialize :set_default_target

    validates :target,

              presence: true,
              inclusion: { in: SUPPORTED_TARGETS }
  end

  protected

  def set_default_target
    self.target ||= self.class.targets[:jabber]
  end
end
