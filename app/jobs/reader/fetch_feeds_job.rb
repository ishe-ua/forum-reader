class Reader::FetchFeedsJob < ActiveJob::Base
  queue_as :fetcher_in

  # Params:
  # +mode+ :forum or :letter
  # +urls+ External urls

  def perform(mode, urls)
  end
end
