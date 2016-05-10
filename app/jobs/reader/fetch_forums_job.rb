module Reader
  # Fetch Forum -s.
  #
  # Clock task.
  class FetchForumsJob < ActiveJob::Base
    queue_as :default

    # Do FetchFeedJob for each Url.
    def perform
      find_forums_for_fetch.each do |url|
        FetchFeedJob.perform_later(url, :forum)
      end
    end

    protected

    def find_forums_for_fetch
      Forum.pluck(:url).uniq
    end
  end
end
