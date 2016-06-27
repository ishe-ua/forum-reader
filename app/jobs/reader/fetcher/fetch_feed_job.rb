module Reader
  module Fetcher
    # Fetch Feed from remote Url.
    #
    # Incoming job for Fetcher.
    class FetchFeedJob < ApplicationJob
      queue_as { Reader::Fetcher::QUEUE_NAME }

      # +Deprecated+ method (should performs in Fetcher).
      #
      # Params:
      # - +url+ Url of Feed

      def perform(_url)
        raise 'Deprecated'
      end
    end
  end
end
