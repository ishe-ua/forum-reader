module Reader
  module Cmd
    # +Help+ command from BoteIn.
    class HelpJob < ApplicationJob
      queue_as :default

      REGEXP = /help/

      def perform(_body, from)
        user = find_user(from)
        if user
          body = CmdMailer.help(user).body.encoded
          ReplyJob.perform_later(body, from)
        end
      end
    end
  end
end
