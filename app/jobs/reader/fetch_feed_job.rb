module Reader
  # Fetch Feed from remote Url.
  #
  # Incoming job for Fetcher.
  class FetchFeedJob < ApplicationJob
    queue_as :default

    # +Deprecated+ method (should performs in Fetcher).
    #
    # Params:
    # - +url+ Url of Feed

    def perform(_url)
      raise 'Deprecated'
    end
  end
end
