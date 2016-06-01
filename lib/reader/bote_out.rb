require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'
require 'blather/client/dsl'

module Reader
  # Send Jabber messages to User.
  module BoteOut
    extend Blather::DSL
    setup(Reader::BOTE_JID, Reader::BOTE_PASSWORD)

    # Reconnect
    disconnected { client.connect }

    QUEUE_NAME = 'reader.bote_out'.to_sym

    class << self
      def run
        EM.run do
          client.run
          EM.add_periodic_timer(1) { process_jobs_from_tube }
        end
      end

      protected

      # Process job from QUEUE_NAME.
      def process_single(job)
        body = Utils::Queues.args_from(job).first
        to = Utils::Queues.args_from(job).second
        say(to, body)
      end

      private

      def process_jobs_from_tube
        @tube ||= Utils::Queues.get_tube(QUEUE_NAME)
        while @tube.peek(:ready)
          job = @tube.reserve
          process_single(job)
          job.delete
        end
      end
    end
  end
end

## Run in console (see Procfile)
Reader::BoteOut.run unless defined?(Rails)
