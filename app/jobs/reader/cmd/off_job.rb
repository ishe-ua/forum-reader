module Reader
  module Cmd
    # +Off+ command from BoteIn
    class OffJob < CommandJob
      queue_as :default

      REGEXP = /^\s*OFF\s*$/i

      def perform(_body, from)
        if (user = find_user_from(from))
          user.change_status if user.status != Status::OFF
          ReplyJob.perform_later(DONE, from)
        end
      end
    end
  end
end
