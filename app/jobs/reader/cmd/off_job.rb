module Reader
  module Cmd
    # +Off+ command from BoteIn.
    class OffJob < CommandJob
      queue_as :default

      REGEXP = /off/

      def perform(_body, from)
        user.change_status if user.status != OFF
        ReplyJob.perform_later(DONE, from)
      end
    end
  end
end
