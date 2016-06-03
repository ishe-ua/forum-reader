module Reader
  # Clean FeedItem -s.
  #
  # Clockwork task
  class CleanerJob < ApplicationJob
    queue_as :default

    # Remove items fetched before this days ago.
    MIN_STORE_TIME = 7.days

    # Remove only if Feed has more items than this count.
    MIN_STORE_ITEMS = 100

    def perform
      Feed.find_each do |feed|
        find_feed_items_for_clean(feed).delete_all
      end
    end

    protected

    def find_feed_items_for_clean(feed)
      if feed.count > MIN_STORE_ITEMS
        feed.feed_items.where('created_at < ?', MIN_STORE_TIME.ago)
      else
        feed.feed_items.none
      end
    end
  end
end
