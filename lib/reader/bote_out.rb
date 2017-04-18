require 'bundler/setup'
require 'blather/client/dsl'

require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'

module Reader
  # Send Jabber messages to User.
  module BoteOut
    extend Blather::DSL

    setup(Reader::BOTE_JID, APP::BOTES_PASSWORD)
    disconnected { client.connect }

    # Queue with incoming messages (from Cmd).
    QUEUE_NAME = 'reader_bote_out'.freeze

    def self.run
      EM.run { client.run }
      EM.add_periodic_timer(20) do
        msg = Blather::Stanza::Message.new('in.shevkun@gmail.com', 'msg', :chat)
        client.write(msg)
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteOut.run unless defined?(Rails)
