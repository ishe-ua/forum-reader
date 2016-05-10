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
  # 6. TODO
  #
  class Fetcher
    QUEUE_NAME = :fetcher

    # Method for <tt>bin/runner</tt>.
    #
    # Enqueue Reader::FetchedFeedJob.
    def self.run
      EventMachine.run do
        # TODO: accept job
        raise_if_bad(resource_type)

        http = EventMachine::HttpRequest.new(url).get
        http.callback do
          FetchedFeedJob.perform_later(url, response, resource_type)
        end
      end
    end

    # Only :forum or :letter_item.
    def self.raise_if_bad(resource_type)
      raise 'Bad resource_type' if resource_type != :forum &&
                                   resource_type != :letter_item
    end
  end
end
