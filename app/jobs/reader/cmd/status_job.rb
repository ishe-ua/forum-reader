module Reader
  module Cmd
    # +Status+ command from BoteIn.
    class StatusJob < ActiveJob::Base
      queue_as :default

      REGEXP = /status/

      def perform(body, from)
        # Do something later
      end
    end
  end
end
