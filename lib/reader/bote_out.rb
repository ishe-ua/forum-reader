require 'bundler/setup'
require 'blather/client/dsl'

require_relative 'reader.rb'

module Reader
  # Send Jabber messages to User.
  module BoteOut
    extend Blather::DSL

    setup(Reader::BOTE_JID, APP::BOTES_PASSWORD)
    disconnected { client.connect }

    # Queue with incoming messages (from Cmd).
    REDIS_LIST = 'reader:bote:out'.freeze

    def self.run
      EM.run do
        client.run
        EM.add_periodic_timer(1) do
          Redis.current
        end
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteOut.run unless defined?(Rails)
