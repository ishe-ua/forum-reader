module Reader
  module Cmd
    # +Off+ command from BoteIn.
    class OffJob < CommandJob
      queue_as :default

      REGEXP = /off/

      def perform(_body, from)
        user = find_user_from(from)
        if user
          user.change_status if user.status != Status::OFF
          ReplyJob.perform_later(DONE, from)
        end
      end
    end
  end
end
