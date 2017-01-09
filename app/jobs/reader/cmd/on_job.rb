module Reader
  module Cmd
    # +On+ command
    class OnJob < CommandJob
      queue_as :default

      REGEXP = /^\s*ON\s*$/i

      def perform(body, from)
        return unless body =~ REGEXP
        return unless (user = find_user_from(from))

        user.reader_set.change_status if user.reader_set.off?
        ReplyJob.perform_later(DONE, from) # TODO: skip if has unreaded forums
      end

      protected

      def send_unreaded_forums
        # TODO: run list cmd for each forum
      end
    end
  end
end
