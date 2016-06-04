module Reader
  module Cmd
    # +List+ command from BoteIn.
    class ListJob < CommandJob
      queue_as :default

      REGEXP = /list/

      before_enqueue { |job| find_user_from(job) }

      def perform(body, from)
        # Do something later
      end
    end
  end
end
