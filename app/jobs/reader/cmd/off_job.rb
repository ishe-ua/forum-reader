module Reader
  module Cmd
    # +Off+ command
    class OffJob < CommandJob
      queue_as :default

      REGEXP = /^\s*OFF\s*$/i

      def perform(body, from)
        return unless body.match?(REGEXP)
        return unless (user = find_user_from(from))

        user.reader_set.change_status if user.reader_set.on?
        ReplyJob.perform_later(DONE, from)
      end
    end
  end
end
