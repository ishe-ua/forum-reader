module Reader
  module Cmd
    # +On+ command from BoteIn.
    class OnJob < ApplicationJob
      queue_as :default

      REGEXP = /on/

      def perform(_body, from)
        user = find_user(from)
        if user
          user.change_status if user.status != ON
          ReplyJob.perform_later(DONE, from)
        end
      end
    end
  end
end
