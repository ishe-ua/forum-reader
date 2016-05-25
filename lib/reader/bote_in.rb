require_relative '../../config/initializers/active_job'

require 'blather/client/dsl'
require_relative '../bote.rb'

module Reader
  # Receive Jabber messages from User.
  module BoteIn
    extend Blather::DSL
    extend Bote

    setup(bote_jid, bote_password)

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
