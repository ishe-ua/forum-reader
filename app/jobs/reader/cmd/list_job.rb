module Reader
  module Cmd
    # +List+ command from BoteIn.
    class ListJob < ApplicationJob
      queue_as :default

      REGEXP = /list/

      def perform(body, from)
        # Do something later
      end
    end
  end
end
