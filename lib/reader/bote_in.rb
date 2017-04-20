require 'bundler/setup'
require 'blather/client/dsl'

require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'

module Reader
  # Receive Jabber messages from User.
  module BoteIn
    extend Blather::DSL

    setup(Reader::BOTE_JID, APP::BOTES_PASSWORD)
    disconnected { client.connect }

    # Auto approve subscription requests
    subscription(:request?) { |s| write_to_stream s.approve! }

    message(:chat?) do |m|
      puts m.body
      EM.next_tick { InJob.perform_later(m.body, m.from.to_s) }
    end

    def self.run
      EM.run { client.run }
    end
  end
end

## Run in console (see Godfile)
Reader::BoteIn.run unless defined?(Rails)
