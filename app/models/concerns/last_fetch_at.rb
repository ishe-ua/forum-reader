# When was last fetch of Feed?
#
# Field +last_fetch_at+ in table:
# * datetime
#
module LastFetchAt
  extend ActiveSupport::Concern

  # Fetch each Url not often than this minutes.
  FETCH_INTERVAL = 2

  class_methods do
    def time_to_fetch?(url)
      feed = Feed.find_by(url: url)
      return true if !feed || !feed.last_fetch_at
      feed.last_fetch_at < (Time.zone.now - FETCH_INTERVAL.minutes)
    end

    def find_for_fetch(model_name)
      raise 'Bad model name' if model_name != :forums &&
                                model_name != :letter_items

      model_name.to_s.singularize.classify.safe_constantize
                .select(:url).uniq
                .select do |url|
        time_to_fetch?(url) ? url : nil
      end
    end
  end
end
