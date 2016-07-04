module Reader
  module Cmd
    # +On+ command from BoteIn
    class OnJob < CommandJob
      queue_as :default

      REGEXP = /^\s*ON\s*$/i

      def perform(_body, from)
        if (user = find_user_from(from))
          user.change_status if user.status != Status::ON
          ReplyJob.perform_later(DONE, from)
        end
      end
    end
  end
end
