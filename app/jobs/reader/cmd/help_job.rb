module Reader
  module Cmd
    # +Help+ command from BoteIn.
    class HelpJob < ActiveJob::Base
      queue_as :default

      REGEXP = /help/

      def perform(_body, from)
        user = find_user(from)
        if user
          text = CmdMailer.help(user).body.encoded
          to = from
          AnswerJob.perform_later(text, to)
        end
      end
    end
  end
end
