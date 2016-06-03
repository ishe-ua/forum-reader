module Reader
  module Cmd
    # +On+ command from BoteIn.
    class OnJob < ApplicationJob
      queue_as :default

      REGEXP = /on/

      def perform(_body, from)
        # Do something later
      end
    end
  end
end
