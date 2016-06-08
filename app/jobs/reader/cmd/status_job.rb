module Reader
  module Cmd
    # +Status+ command from BoteIn
    class StatusJob < CommandJob
      queue_as :default

      REGEXP = /status/

      def perform(_body, from)
        user = find_user_from(from)
        if user
          body = (user.status == ON ? OFF : ON).upcase
          ReplyJob.perform_later(body, from)
        end
      end
    end
  end
end
