module Reader
  # Fetch Feed from remote Url.
  class FetchFeedJob < ActiveJob::Base
    queue_as -> { Fetcher::QUEUE_NAME }

    # Set job with params to queue and anything else.
    #
    # Params:
    # - +url+ Url
    # - +resource_type+ :forum or :letter_item

    def perform(url, resource_type)
      raise 'Empty method'
    end

    protected

    def raise_if_unsupported_resource_type
      raise 'Unsupported resource' if
        resource_type != :forum &&
        resource_type != :letter_item
    end

    # Reject job if last_fetch_at is
    def check_last_fetch_at
    end
  end
end
