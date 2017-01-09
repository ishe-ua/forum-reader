module Reader
  module Cmd
    # +Help+ command
    class HelpJob < CommandJob
      queue_as :default

      REGEXP = /^\s*HELP\s*$/i

      def perform(body, from)
        return unless body =~ REGEXP
        return unless (user = find_user_from(from))

        text = ReplyMailer.help(user).body.encoded
        ReplyJob.perform_later(text, from) if text.present?
      end
    end
  end
end
