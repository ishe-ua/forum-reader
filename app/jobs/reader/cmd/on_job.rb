module Reader
  module Cmd
    # +On+ command from BoteIn.
    class OnJob < CommandJob
      queue_as :default

      REGEXP = /on/

      before_enqueue { |job| find_user_from(job) }

      def perform(_body, from)
        user.change_status if user.status != ON
        ReplyJob.perform_later(DONE, from)
      end
    end
  end
end
