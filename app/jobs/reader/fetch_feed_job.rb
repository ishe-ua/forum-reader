module Reader
  # Fetch Feed from remote Url.
  #
  # Incoming job for Fetcher.
  #
  class FetchFeedJob < ApplicationJob
    queue_as { Reader::Fetcher::QUEUE_NAME }

    # +Deprecated+ method (should performs in Fetcher).
    #
    # Params:
    # - +url+ Url of Feed
    # - +resource_type+ See Fetcher::raise_if_bad

    def perform(_url, _resource_type)
      raise 'Deprecated'
    end
  end
end
