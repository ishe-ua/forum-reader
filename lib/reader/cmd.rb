module Reader
  # Command.
  module Cmd
    class << self
      protected

      # Where to find? Token is value from LastJob or ListJob.
      #
      # Return Forum, Letter or LetterItem

      def find_obj_by(token)
      end

      # Find news in Feed between to times.
      #
      # Return FeedItem 's

      def find_news_in(url, time1, time2)
      end
    end
  end
end
