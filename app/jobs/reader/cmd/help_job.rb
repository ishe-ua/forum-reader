module Reader
  module Cmd
    # +Help+ command from BoteIn
    class HelpJob < CommandJob
      queue_as :default

      REGEXP = /help/

      def perform(_body, from)
        user = find_user_from(from)
        body = ReplyMailer.help(user).body.encoded # TODO: cache for each locale

        ReplyJob.perform_later(body, from) if user && body.present?
      end
    end
  end
end
