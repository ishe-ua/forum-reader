module Reader
  # Process response from FetchFeedJob.
  #
  # Also enqueue SendForumsJob if need.
  class FetchedFeedJob < ApplicationJob
    queue_as :default

    # Params:
    # - +url+ Url of Feed
    # - +feed_stream+ Response from Fetcher::process_incoming

    def perform(url, feed_stream)
      feed = find_or_create_feed_by(url)
      news_count = parse_and_save_news(feed, feed_stream)
      Sender::SendForumsJob.perform_later(url) if news_count.positive?
    end

    protected

    def find_or_create_feed_by(url)
      @feed ||= Feed.find_or_create_by!(url: url)
    end

    # Return news count or 0 if exception.
    #
    # <tt>WARN:</tt> core method!!
    def parse_and_save_news(feed, feed_stream)
      news = Feedjira::Feed.parse(feed_stream).entries.select do |entry|
        feed_item = build_feed_item_from(entry, feed)
        feed_item.save if feed.last_fetch_at.nil? ||
                          feed.last_fetch_at < feed_item.date
      end

      news.count
    rescue
      0
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
