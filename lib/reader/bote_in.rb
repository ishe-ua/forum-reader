require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'
require 'blather/client/dsl'

module Reader
  # Receive Jabber messages from User.
  module BoteIn
    extend Blather::DSL
    setup(Reader::BOTE_JID, Reader::BOTE_PASSWORD)

    # Auto approve subscription requests
    subscription :request? do |s|
      write_to_stream s.approve!
    end

    message :chat?, :body do |m|
      write_to_stream m.reply
    end

    def self.run
      EM.run { client.run }
    end
  end
end

## Run in console (see Procfile)
Reader::BoteIn.run unless defined?(Rails)
