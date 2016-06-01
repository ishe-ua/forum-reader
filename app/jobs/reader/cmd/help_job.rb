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
          SendMessageJob.perform_later(text, to)
        end
      end

      protected

      # Remove resource from incoming Jabber and find User
      def find_user(from) # TODO: unify
        jid_without_resource = Blather::JID.new(from).strip
        User.find_by(jabber: jid_without_resource)
      end
    end
  end
end
