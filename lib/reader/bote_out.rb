require 'bundler/setup'
require 'blather/client/dsl'

require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'

module Reader
  # Send Jabber messages to User.
  module BoteOut
    extend Blather::DSL
    extend Utils::Queues

    setup(Reader::BOTE_JID, APP::BOTES_PASSWORD)
    disconnected { client.connect }

    # Queue with incoming messages (from Cmd).
    QUEUE_NAME = 'reader_bote_out'.freeze

    class << self
      # rubocop:disable LineLength
      def run
        EM.run do
          client.run
          EM.add_periodic_timer(1) { jobs_from(QUEUE_NAME) { |job| process_incoming(job) } }
        end
      end

      protected

      def process_incoming(job)
        text = args_from(job).first
        to = args_from(job).second

        say(to, text.strip)
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteOut.run unless defined?(Rails)
