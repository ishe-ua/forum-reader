module Reader
  module Cmd
    # +Status+ command from BoteIn
    class StatusJob < CommandJob
      queue_as :default

      REGEXP = /^\s*STATUS\s*$/i

      def perform(_body, from)
        if (user = find_user_from(from))
          body = (user.status == ON ? OFF : ON).upcase
          ReplyJob.perform_later(body, from)
        end
      end
    end
  end
end
