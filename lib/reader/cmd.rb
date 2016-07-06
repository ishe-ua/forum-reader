module Reader
  # Command from BoteIn.
  module Cmd
    # Where to find? Token is value from LastJob or ListJob.
    #
    # Return Forum, Letter or LetterItem

    def find_obj_by(user, token)
      rel = (find_in_forums(user, token) ||
             find_in_letters(user, token) ||
             find_in_letter_items(user, token))

      rel ? rel.order(:position).first : nil
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

    protected

    # Prepare token for <tt>PG#ILIKE</tt> function
    def iliked(token)
      "%#{token}%"
    end

    private

    def find_in_forums(user, token)
      rel = user.forums.where('name ILIKE ?', iliked(token))
      rel.any? ? rel : nil
    end

    def find_in_letters(user, token)
      rel = user.letters.where('name ILIKE ?', iliked(token))
      rel.any? ? rel : nil
    end

    def find_in_letter_items(user, token)
      rel = LetterItem
            .where(letter_id: user.letters.pluck(:id))
            .where('name ILIKE ?', iliked(token))

      rel.any? ? rel : nil
    end
  end
end
