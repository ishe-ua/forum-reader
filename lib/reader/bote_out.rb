require 'bundler/setup'

require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'

module Reader
  # Send Jabber messages to User.
  module BoteOut
    # Queue with incoming messages (from Cmd).
    QUEUE_NAME = 'reader_bote_out'.freeze

    class << self
      def run
        # TODO
      end
    end
  end
end

## Run in console (see Godfile)
Reader::BoteOut.run unless defined?(Rails)
