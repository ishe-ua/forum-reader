module Reader
  module Fetcher
    # Find Forum -s that need to fetch.
    #
    # +return+ Url list
    def find_forums_for_fetch
      Forum.pluck(:url).uniq
    end
  end
end
