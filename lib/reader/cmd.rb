module Reader
  # Command.
  module Cmd
    protected

    # Where to find? Token is value from LastJob or ListJob.
    #
    # Return Forum, Letter or LetterItem

    def find_obj_by(user, token)
      f = find_in_forums(user, token)
      l = find_in_letters(user, token) unless f
      i = find_in_letter_items(user, token) unless f && l

      f || l || i
    end

    # Find news in Feed between to times.
    #
    # Return FeedItem 's like +Array+

    def find_news_in(url, time1, time2)
      # TODO
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
