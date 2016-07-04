module Reader
  module Fetcher
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
        SendForumsJob.perform_later(url) if news_count > 0
      end

      protected

      def find_or_create_feed_by(url)
        @feed ||= Feed.find_or_create_by!(url: url)
      end

      def parse_and_save_news(feed, feed_stream)
        Feedjira::Feed.parse(feed_stream).entries.select do |entry|
          feed_item = build_feed_item_from(entry, feed)
          feed_item.save if feed.last_fetch_at.nil? ||
                            feed.last_fetch_at < feed_item.date
        end
                      .count
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
end
