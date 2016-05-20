module Reader
  # Clean FeedItem -s.
  module Cleaner
    # Remove items fetched before this days ago.
    STORE_MIN_DAYS = 10

    # Remove only if Feed has more items than this count.
    STORE_MIN_ITEMS = 10

    def self.run
      # TODO
    end
  end
end
