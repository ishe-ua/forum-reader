require 'bundler/setup'

require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'

module Reader
  # Receive Jabber messages from User.
  module BoteIn
    extend Utils::Xmpp

    class << self
      def run
        start(Reader::BOTE_JID)

        wait_msg do |body, from|
          cmd = body.split[0]
          job = job_for(cmd) || Cmd::ListJob
          job.perform_later(body, from)
        end
      end

      protected

      def job_for(_cmd)
        klass = nil

        [Cmd::HelpJob,
         Cmd::StatusJob,
         Cmd::OnJob,
         Cmd::OffJob,
         Cmd::LastJob,
         Cmd::ListJob].each { |cmd| klass = cmd unless klass }

        klass
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteIn.run unless defined?(Rails)
