module Reader
  # Fetch Letter -s (LetterItem -s).
  #
  # Clockwork task
  class FetchLettersJob < ActiveJob::Base
    queue_as :default

    # Do FetchFeedJob for each Url.
    def perform
      find_letters_for_fetch.each do |url|
        FetchFeedJob.perform_later(url, :letter_item)
      end
    end

    protected

    def find_letter_items_for_fetch
      LetterItem.pluck(:url).uniq
    end
  end
end
