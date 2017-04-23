module Reader
  module Cmd
    # +List+ command
    class ListJob < LastJob
      queue_as :default

      # Default command (see BoteIn)
      REGEXP = /^\s*\S+\s*$/i

      def perform(body, from)
        super(body, from)
      end
    end
  end
end
