module Reader
  module Cmd
    # +List+ command from BoteIn.
    class ListJob < CommandJob
      queue_as :default

      REGEXP = /list/

      # Like LastJob
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
          name: find_name_from(tokens[0]),
          plus: with_plus?(tokens[0]),
          count: find_count_from(tokens[1])
        }
      end

      def reply_to(from)
        # TODO
      end
    end
  end
end
