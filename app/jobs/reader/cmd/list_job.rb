module Reader
  module Cmd
    # +List+ command
    class ListJob < LastJob
      queue_as :default

      # Default command (see BoteIn)
      REGEXP = /^\s*\S+\s*$/i

      def perform(body, from)
        super(body, from) { |obj| update_last_post_at(obj) }
      end

      protected

      def update_last_post_at(obj)
        t = Time.zone.now
        obj.update(last_post_at: Time.zone.now)
        obj.letter_items.update_all(last_post_at: t) if obj.is_a?(Letter)
      end
    end
  end
end
