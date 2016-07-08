module Reader
  module Cmd
    # +List+ command
    class ListJob < LastJob
      queue_as :default

      # Default command (see BoteIn)
      REGEXP = /^\s*\S+\s*$/i
    end
  end
end
