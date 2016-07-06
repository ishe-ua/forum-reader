module Reader
  module Cmd
    # +List+ command from BoteIn
    class ListJob < LastJob
      queue_as :default

      # Default command (see BoteIn)
      REGEXP = /^\s*\S+\s*$/i

      protected

      def find_params_from(body)
        super(body, :list)
      end

      private

      def from(obj)
        super(obj, :list)
      end
    end
  end
end
