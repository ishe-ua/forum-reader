module Reader
  # Process response from FetchFeedJob.
  class FetchedFeedJob < ActiveJob::Base
    queue_as :default

    # Params:
    # - +url+ Url of Feed
    # - +response+ Body from request to +url+
    # - +resource_type+ See Fetcher::raise_if_bad

    def perform(url, response, resource_type)
      Fetcher.raise_if_bad(resource_type)
      parse_and_save_updates(url, response)
      send_forum_updates_to_users(url) if resource_type == Forum.to_s
    end

    protected

    def find_or_create_feed_by(url)
      @feed ||= Feed.find_or_create_by(url: url)
    end

    def parse_and_save_updates(url, response)
      # TODO
    end

    def send_forum_updates_to_users(url)
      # TODO
    end
  end
end
