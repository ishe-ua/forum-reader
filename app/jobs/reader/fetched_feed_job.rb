module Reader
  # Process fetched Url body from Fetcher.
  class FetchedFeedJob < ActiveJob::Base
    queue_as :default

    before_enqueue do |job|
      resource_type = job.arguments.last
      Fetcher.raise_if_bad(resource_type)
    end

    # Params:
    # - +url+ Url
    # - +response+ From request to +url+
    # - +resource_type+ See Fetcher::raise_if_bad

    def perform(url, response, resource_type)
      parse_and_save_updates(url, response)
      send_forum_updates_to_users(url) if resource_type == :forum
    end

    protected

    def find_or_create_feed_by(url)
      @feed ||= Feed.find_or_create_by(url: url)
    end

    def parse_and_save_updates(url, response)
    end

    def send_forum_updates_to_users(url)
    end
  end
end
