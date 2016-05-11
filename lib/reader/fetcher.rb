module Reader
  # Fetch Forum -s and Letter -s periodically from remote Url -s.
  #
  # Parts:
  #
  # 1. Clock
  # 2. FetchForumsJob
  # 3. FetchLettersJob
  # 4. FetchFeedJob
  # 5. FetchedFeedJob
  #
  class Fetcher
    QUEUE_NAME = :fetcher

    # Method for <tt>bin/runner</tt>.
    #
    # Wait for FetchFeedJob -s and process them.
    def self.run
      Backburner.work(QUEUE_NAME, worker: Backburner::Workers::Threading)
    end

    # Only :forum or :letter_item.
    def self.raise_if_bad(resource_type)
      raise 'Bad resource_type' if resource_type != :forum &&
                                   resource_type != :letter_item
    end
  end
end
