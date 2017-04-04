module Reader
  # Fetch and parse Feed from remote Url.
  class FetchFeedJob < ApplicationJob
    queue_as :default

    def perform(url)
      feed = find_or_create_feed_by(url)
      news = find_news(feed)
      SendForumsJob.perform_later(url) if news&.any?
    end

    protected

    def find_or_create_feed_by(url)
      Feed.find_or_create_by!(url: url)
    end

    # <tt>WARN:</tt> core method!!
    def find_news(feed)
      Feedjira::Feed.fetch_and_parse(feed.url).entries.select do |entry|
        feed_item = build_feed_item_from(entry, feed)
        feed_item.save if feed.last_fetch_at.nil? ||
                          feed.last_fetch_at < feed_item.date
      end
    rescue
      nil
    end

    private

    def build_feed_item_from(entry, feed)
      feed.feed_items.new(
        url:   purify(entry.url),
        date:  entry.published,
        theme: purify(entry.title),
        text:  purify(entry.summary)
      )
    end

    def purify(str)
      str ? str.strip : ''
    end
  end
end
