module Reader
  module Cmd
    # +Help+ command from BoteIn.
    class HelpJob < CommandJob
      queue_as :default

      REGEXP = /help/

      def perform(_body, from)
        body = CmdMailer.help(user).body.encoded
        ReplyJob.perform_later(body, from)
      end
    end
  end
end
