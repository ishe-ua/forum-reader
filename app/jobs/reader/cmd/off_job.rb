module Reader
  module Cmd
    # +Off+ command from BoteIn.
    class OffJob < ApplicationJob
      queue_as :default

      REGEXP = /off/

      def perform(_body, from)
        # Do something later
      end
    end
  end
end
