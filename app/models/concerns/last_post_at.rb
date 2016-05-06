# When was last post (delivery, send) to User?
#
# Field +last_post_at+ in table:
# * datetime
#
module LastPostAt
  extend ActiveSupport::Concern

  included do
  end
end
