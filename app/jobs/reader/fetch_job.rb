module Reader
  # Find Url -s for fetch.
  #
  # Clockwork task
  class FetchJob < ApplicationJob
    queue_as :default

    # Enqueue FetchFeedJob for each Url.
    def perform
      urls = Feed.find_for_fetch(:forums) | Feed.find_for_fetch(:letter_items)
      urls.each { |url| FetchFeedJob.perform_later(url) }
    end
  end
end
