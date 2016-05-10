module Reader
  # Fetch Feed from remote Url.
  #
  # Incoming job for Fetcher.
  class FetchFeedJob < ActiveJob::Base
    queue_as { Reader::Fetcher::QUEUE_NAME }

    before_enqueue do |job|
      resource_type = job.arguments.second
      Fetcher.raise_if_bad(resource_type)
    end

    # Params:
    # - +url+ Url
    # - +resource_type+ See Fetcher::raise_if_bad

    def perform(_url, _resource_type)
      raise 'stub'
    end
  end
end
