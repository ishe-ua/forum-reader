module Reader
  # Fetch Forum -s and Letter -s periodically from remote Url -s.
  #
  # Also see:
  #
  # 1. FetchForumsJob
  # 2. FetchLettersJob
  # 3. FetchFeedJob
  # 4. TODO
  #
  class Fetcher
    QUEUE_NAME = :fetcher

    def self.run
      puts 'fetcher'
    end
  end
end
