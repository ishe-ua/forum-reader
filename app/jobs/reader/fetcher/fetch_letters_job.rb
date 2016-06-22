module Reader
  module Fetcher
    # Fetch Letter -s (LetterItem -s).
    #
    # Clockwork task
    class FetchLettersJob < ApplicationJob
      queue_as :default

      # Do FetchFeedJob for each Url.
      def perform
        Feed.find_for_fetch(:letter_items).each do |url|
          FetchFeedJob.perform_later(url, LetterItem.to_s)
        end
      end
    end
  end
end
