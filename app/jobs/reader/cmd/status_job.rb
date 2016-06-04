module Reader
  module Cmd
    # +Status+ command from BoteIn.
    class StatusJob < CommandJob
      queue_as :default

      REGEXP = /status/

      before_enqueue { |job| find_user_from(job) }

      def perform(_body, from)
        body = (user.status == ON ? OFF : ON).upcase
        ReplyJob.perform_later(body, from)
      end
    end
  end
end
