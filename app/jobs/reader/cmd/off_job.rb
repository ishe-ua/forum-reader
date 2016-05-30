module Reader
  module Cmd
    # +Off+ command from BoteIn.
    class OffJob < ActiveJob::Base
      queue_as :default

      REGEXP = /off/

      def perform(body, from)
        # Do something later
      end
    end
  end
end
