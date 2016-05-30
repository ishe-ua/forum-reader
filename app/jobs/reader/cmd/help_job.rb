module Reader
  module Cmd
    # +Help+ command from BoteIn.
    class HelpJob < ActiveJob::Base
      queue_as :default

      REGEXP = /help/

      def perform(body, from)
        # Do something later
      end
    end
  end
end
