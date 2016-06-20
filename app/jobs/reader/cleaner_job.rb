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
      rel = feed.feed_items
      rel.where('created_at < ?', MIN_STORE_TIME.ago) if rel.count >
                                                         MIN_STORE_ITEMS
      rel
    end
  end
end
