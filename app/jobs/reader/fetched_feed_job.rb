module Reader
  # Process response from FetchFeedJob.
  class FetchedFeedJob < ApplicationJob
    queue_as :default

    # See #find_or_create_feed_by
    attr_reader :feed

    # Params:
    # - +url+ Url of Feed
    # - +response+ Response from Fetcher::process_single
    # - +resource_type+ See Fetcher::raise_if_bad

    def perform(url, response, resource_type)
      Fetcher.raise_if_bad(resource_type)
      find_or_create_feed_by(url)

      parse_and_save_updates(response)
      send_forum_updates_to_users if resource_type == Forum.to_s
    end

    protected

    def find_or_create_feed_by(url)
      @feed ||= Feed.find_or_create_by(url: url)
    end

    def parse_and_save_updates(response)
      response.entries.each do |entry|
        feed_item = build_feed_item_from(entry)
        feed_item.save if feed.last_fetch_at.blank? ||
                          feed.last_fetch_at < feed_item.date
      end
    end

    def send_forum_updates_to_users
      Forum.where(url: feed.url).find_each do |_forum|
        # TODO: send jabber msg or email to user
      end
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
      str.present? ? str.strip : ''
    end
  end
end
