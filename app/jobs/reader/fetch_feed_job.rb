module Reader
  # Fetch Feed from remote Url.
  #
  # Incoming job for Fetcher.
  class FetchFeedJob < ActiveJob::Base
    queue_as { Reader::Fetcher::QUEUE_NAME }

    # Invoke FetchedFeedJob with response after remote request.
    #
    # Params:
    # - +url+ Url
    # - +resource_type+ See Fetcher::raise_if_bad

    def perform(url, resource_type)
      Fetcher.raise_if_bad(resource_type)
      response = Faraday.get(url).body

      unless response.blank?
        FetchedFeed.perform_later(url, response, resource_type)
      end
    end
  end
end
