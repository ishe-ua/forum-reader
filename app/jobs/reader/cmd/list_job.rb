module Reader
  module Cmd
    # +List+ command from BoteIn.
    class ListJob < CommandJob
      queue_as :default

      # Default command
      REGEXP = //

      # Like LastJob
      def perform(body, from)
        user = find_user_from(from)
        params = find_params_from(body)

        reply_to(from) if user && valid?(params)
      end

      protected

      def find_params_from(body)
        tokens = body.split
        params_from(tokens[0], tokens[1])
      end

      def reply_to(from)
        # TODO
      end
    end
  end
end
