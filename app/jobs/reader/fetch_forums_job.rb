class Reader::FetchForumsJob < ActiveJob::Base
  queue_as :default

  def perform
    Reader.find_forums_for_fetch.each do |forum_url|
      FetchFeeds.perform_later(:forum, [forum_url])
    end
  end
end
