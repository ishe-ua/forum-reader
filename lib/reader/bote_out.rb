require 'bundler/setup'
require 'blather/client/dsl'

require_relative 'reader.rb'
require_relative '../../config/initializers/gem_redis.rb'

require 'json'

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
          while (msg = redis.rpop(REDIS_LIST))
            msg = JSON.parse(msg, symbolize_names: true)
            say(msg[:to], msg[:text])
          end
        end
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteOut.run unless defined?(Rails)
