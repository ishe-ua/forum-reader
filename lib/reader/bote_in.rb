require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'
require 'blather/client/dsl'

module Reader
  # Receive Jabber messages from User.
  module BoteIn
    extend Blather::DSL

    setup(Reader::BOTE_JID, APP::BOTES_PASSWORD)
    disconnected { client.connect }

    # Auto approve subscription requests
    subscription(:request?) { |s| write_to_stream s.approve! }

    # Order is <tt>VERY IMPORTANT</tt>.
    SUPPORTED_COMMANDS =
      [
        Cmd::HelpJob,
        Cmd::StatusJob,
        Cmd::OnJob,
        Cmd::OffJob,
        Cmd::LastJob,
        Cmd::ListJob
      ].each do |cmd|
        message(:chat?, body: cmd::REGEXP) do |m|
          cmd.perform_later(m.body, m.from)
          halt
        end
      end

    def self.run
      EM.run { client.run }
    end
  end
end

## Run in console (see Godfile)
Reader::BoteIn.run unless defined?(Rails)
