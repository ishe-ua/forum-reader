module Reader
  module Fetcher
    # Find LetterItem -s that need to fetch.
    #
    # +return+ Url list
    def find_letter_items_for_fetch
      LetterItem.pluck(:url).uniq
    end
  end
end
