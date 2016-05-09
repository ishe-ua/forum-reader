class Reader::FetchLetterItemsJob < ActiveJob::Base
  queue_as :default

  def perform
    Reader.find_letters_for_fetch.each do |letter_items_urls|
      FetchFeeds.perform_later(:letter, letter_items_urls)
    end
  end
end
