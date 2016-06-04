module Reader
  module Cmd
    # +Help+ command from BoteIn.
    class HelpJob < CommandJob
      queue_as :default

      REGEXP = /help/

      before_enqueue { |job| find_user_from(job) }

      def perform(_body, from)
        body = CmdMailer.help(user).body.encoded
        ReplyJob.perform_later(body, from)
      end
    end
  end
end
