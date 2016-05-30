require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'
require 'blather/client/dsl'

module Reader
  # Receive Jabber messages from User.
  module BoteIn
    extend Blather::DSL
    setup(Reader::BOTE_JID, Reader::BOTE_PASSWORD)

    # Auto approve subscription requests
    subscription :request? do |s|
      write_to_stream s.approve!
    end

    COMMANDS =
      [
        Cmd::HelpJob,
        Cmd::StatusJob,
        Cmd::OnJob,
        Cmd::OffJob,
        Cmd::LastJob,
        Cmd::ListJob
      ].each do |cmd|
        # rubocop:disable LineLength
        message(:chat?, body: cmd::REGEXP) { |m| cmd.perform_later(m.body, m.from) }
      end

    def self.run
      EM.run { client.run }
    end
  end
end

## Run in console (see Procfile)
Reader::BoteIn.run unless defined?(Rails)
