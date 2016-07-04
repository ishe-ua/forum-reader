module Reader
  module Cmd
    # +Help+ command from BoteIn
    class HelpJob < CommandJob
      queue_as :default

      REGEXP = /^\s*HELP\s*$/i

      def perform(_body, from)
        if (user = find_user_from(from))
          body = ReplyMailer.help(user).body.encoded
          ReplyJob.perform_later(body, from) if body.present?
        end
      end
    end
  end
end
