require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'
require 'blather/client/dsl'

module Reader
  # Send Jabber messages to User.
  module BoteOut
    extend Blather::DSL
    extend Utils::Queues

    setup(Reader::BOTE_JID, Reader::BOTE_PASSWORD)
    disconnected { client.connect }

    # Queue with incoming messages (from Cmd).
    QUEUE_NAME = 'reader.bote_out'.to_sym

    class << self
      def run
        EM.run do
          client.run
          # rubocop:disable LineLength
          EM.add_periodic_timer(1) { jobs_from(QUEUE_NAME) { |job| process_incoming(job) } }
        end
      end

      protected

      def process_incoming(job)
        body = args_from(job).first
        to = args_from(job).second
        say(to, body)
      end
    end
  end
end

## Run in console (see Procfile)
Reader::BoteOut.run unless defined?(Rails)
