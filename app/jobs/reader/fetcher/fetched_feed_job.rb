module Reader
  module Fetcher
    # Process response from FetchFeedJob
    class FetchedFeedJob < ApplicationJob
      queue_as :default

      # Also enqueue SendForumsJob if need.
      #
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
        feed_stream.entries.select do |entry|
          feed_item = build_feed_item_from(entry)
          feed_item.save if feed.last_fetch_at.nil? ||
                            feed.last_fetch_at < feed_item.date
        end
                   .count
      end

      private

      def build_feed_item_from(entry)
        feed_item = feed.build_feed_item(
          url:   purify(entry.url),
          date:  entry.data,
          theme: purify(entry.title),
          text:  purify(entry.text)
        )

        feed_item
      end

      def purify(str)
        str ? str.strip : ''
      end
    end
  end
end
