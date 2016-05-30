module Reader
  module Cmd
    # +On+ command from BoteIn.
    class OnJob < ActiveJob::Base
      queue_as :default

      REGEXP = /on/

      def perform(body, from)
        # Do something later
      end
    end
  end
end
