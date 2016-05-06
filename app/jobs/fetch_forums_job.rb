class FetchForumsJob < ActiveJob::Base
  queue_as :default

  def perform
    Reader.find_forums_for_fetch.each do |forum_url|
      # FetchFeed.perform_later(forum_url, :forum)
    end
  end
end
