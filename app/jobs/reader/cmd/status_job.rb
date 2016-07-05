module Reader
  module Cmd
    # +Status+ command from BoteIn
    class StatusJob < CommandJob
      queue_as :default

      REGEXP = /^\s*STATUS\s*$/i

      def perform(body, from)
        return unless body =~ REGEXP
        if (user = find_user_from(from))
          text = (user.reader_set.on? ? Status::ON : Status::OFF).upcase
          ReplyJob.perform_later(text, from)
        end
      end
    end
  end
end
