module Reader
  module Cmd
    # +Last+ command from BoteIn.
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /last/

      def perform(body, from)
        # Do something later
      end
    end
  end
end
