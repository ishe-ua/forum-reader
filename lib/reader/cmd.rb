module Reader
  # Command.
  module Cmd
    protected

    # Where to find? Token is value from LastJob or ListJob.
    #
    # Return Forum, Letter or LetterItem

    def find_obj_by(user, token)
      find_in_forums(user, token) ||
        find_in_letters(user, token) ||
        find_in_letter_items(user, token)
    end

    # Find news in Feed between to times.
    #
    # Return FeedItem 's like +Array+

    def find_news_in(feed, time1, time2)
      time2 = Time.zone.now unless time2
      time1 = time2 unless time1

      feed.feed_items
          .where('created_at > ? AND created_at <= ?', time1, time2)
          .order(:created_at)
    end

    private

    def find_in_forums(user, token)
      user.forums.where('name ILIKE ?', token).order(:position).first
    end

    def find_in_letters(user, token)
      user.letters.where('name ILIKE ?', token).order(:position).first
    end

    def find_in_letter_items(user, token)
      LetterItems
        .where(letter_id: user.letters.pluck(:id))
        .where('name ILIKE ?', token).order(:position).first
    end
  end
end
