require 'bundler/setup'

require_relative '../../config/initializers/active_job'
require_relative 'reader.rb'

module Reader
  # Receive Jabber messages from User.
  module BoteIn
    extend Utils::Xmpp

    def self.run
      connect(Reader::BOTE_JID)
    end
  end
end

## Run in console (see Godfile)
Reader::BoteIn.run unless defined?(Rails)
