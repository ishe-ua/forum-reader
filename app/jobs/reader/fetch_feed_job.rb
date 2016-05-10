module Reader
  # Fetch Feed from remote Url.
  #
  # Incoming job for Fetcher.
  class FetchFeedJob < ActiveJob::Base
    queue_as { Reader::Fetcher::QUEUE_NAME }

    before_enqueue { |job| create_feed_if_absent(job) }

    # Params:
    # - +url+ Url
    # - +resource_type+ :forum or :letter_item

    def perform(_url, _resource_type)
      raise 'stub'
    end

    protected

    def create_feed_if_absent(job)
      url = job.arguments.first
      Feed.find_or_create_by!(url: url)
    end
  end
end
