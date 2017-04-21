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

    class << self
      def run
        EM.run do
          client.run

          EM.tick_loop do
            next unless client.connected? || redis.connected?
            from_redis_to_jabber
          end
        end
      end

      protected

      def from_redis_to_jabber
        msg = redis.rpop(REDIS_LIST)
        if msg
          msg = JSON.parse(msg, symbolize_names: true)
          say(msg[:to], msg[:text])
        else
          sleep 0.1
        end
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteOut.run unless defined?(Rails)
