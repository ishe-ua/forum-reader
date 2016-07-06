module Reader
  module Cmd
    # +On+ command
    class OnJob < CommandJob
      queue_as :default

      REGEXP = /^\s*ON\s*$/i

      def perform(body, from)
        return unless body =~ REGEXP
        if (user = find_user_from(from))
          user.reader_set.change_status if user.reader_set.off?
          ReplyJob.perform_later(DONE, from)
        end
      end
    end
  end
end
