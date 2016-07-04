module Reader
  module Cmd
    # +List+ command from BoteIn
    class ListJob < CommandJob
      queue_as :default

      # Default command
      REGEXP = /^\s*\S+\s*$/i

      include Cmd

      # Like LastJob
      def perform(body, from)
        if (user = find_user_from(from))
          params = find_params_from(body)
          reply_to(from) if valid?(params)
        end
      end

      protected

      def find_params_from(body)
        tokens = body.split
        params_from(tokens[0], tokens[1]).merge(count: CommonJob::MAX_SELECTION)
      end

      def reply_to(from)
        # TODO: like LastJob#reply_to
      end
    end
  end
end
