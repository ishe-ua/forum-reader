module Reader
  module Cmd
    # +Last+ command from BoteIn.
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /last/

      # Like ListJob
      def perform(body, from)
        user = find_user_from(from)
        params = find_params_from(body)

        reply_to(from) if user &&
                          params &&
                          params[:name].present?
      end

      protected

      def find_params_from(body)
        tokens = body.split

        {
          name: find_name_from(tokens[1]),
          plus: with_plus?(tokens[1]),
          count: find_count_from(tokens[2])
        }
      end

      def reply_to(from)
        # TODO
      end
    end
  end
end
