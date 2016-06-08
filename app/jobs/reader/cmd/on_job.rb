module Reader
  module Cmd
    # +On+ command from BoteIn
    class OnJob < CommandJob
      queue_as :default

      REGEXP = /on/

      def perform(_body, from)
        user = find_user_from(from)
        if user
          user.change_status if user.status != Status::ON
          ReplyJob.perform_later(DONE, from)
        end
      end
    end
  end
end
