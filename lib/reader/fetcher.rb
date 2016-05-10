module Reader
  # Fetch Forum -s and Letter -s periodically from remote Url -s.
  #
  # See:
  #
  # 1. Clock
  # 2. FetchForumsJob
  # 3. FetchLettersJob
  # 4. FetchUrlJob
  # 5. TODO
  #
  class Fetcher
    QUEUE_NAME = :fetcher

    def self.run
      puts 'fetcher'
    end
  end
end
