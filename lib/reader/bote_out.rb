module Reader
  # Send Jabber messages to User.
  module BoteOut
    def self.run
      # TODO
    end
  end
end

## Run in console (see Procfile)
Reader::BoteOut.run unless defined?(Rails)
