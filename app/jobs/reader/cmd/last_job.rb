module Reader
  module Cmd
    # +Last+ command from BoteIn.
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /last/

      before_enqueue { |job| find_user_from(job) }

      def perform(body, from)
        # Do something later
      end
    end
  end
end
