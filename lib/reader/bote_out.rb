require 'bundler/setup'
require 'blather/client/dsl'

require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'

require 'sidekiq/api' # TODO

module Reader
  # Send Jabber messages to User.
  module BoteOut
    extend Blather::DSL

    setup(Reader::BOTE_JID, APP::BOTES_PASSWORD)
    disconnected { client.connect }

    # Queue with incoming messages (from Cmd).
    QUEUE_NAME = 'reader_bote_out'.freeze

    def self.run
      EM.run do
        client.run
        EM.add_periodic_timer(1) do
          q = Sidekiq::Queue.new(QUEUE_NAME)
          q.each do |job|
            text = job.args.first['arguments'].first
            to = job.args.first['arguments'].second

            say(to, text)
            job.delete
          end
        end
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteOut.run unless defined?(Rails)
