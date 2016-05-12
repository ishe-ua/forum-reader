module Reader
  # Fetch Feed from remote Url.
  #
  # Incoming job for Fetcher.
  class FetchFeedJob < ActiveJob::Base
    queue_as { Reader::Fetcher::QUEUE_NAME }

    # +Deprecated+ method.
    #
    # Params:
    # - +url+ Url of Feed
    # - +resource_type+ See Fetcher::raise_if_bad

    def perform(_url, _resource_type)
      raise 'deprecated'
    end
  end
end
