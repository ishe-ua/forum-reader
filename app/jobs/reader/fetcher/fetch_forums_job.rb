module Reader
  module Fetcher
    # Fetch Forum -s.
    #
    # Clockwork task
    class FetchForumsJob < ApplicationJob
      queue_as :default

      # Do FetchFeedJob for each Url.
      def perform
        Feed.find_for_fetch(:forums).each do |url|
          FetchFeedJob.perform_later(url)
        end
      end
    end
  end
end
