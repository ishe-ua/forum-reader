module Reader
  module Cmd
    # +Last+ command from BoteIn.
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /last/

      include Cmd # TODO

      # Like ListJob
      def perform(body, from)
        user = find_user_from(from)
        params = find_params_from(body)

        reply_to(from) if user && valid?(params)
      end

      protected

      def find_params_from(body)
        tokens = body.split
        params_from(tokens[1], tokens[2])
      end

      def reply_to(from)
        # TODO
      end
    end
  end
end
