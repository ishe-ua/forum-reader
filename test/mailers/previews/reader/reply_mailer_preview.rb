module Reader
  # Preview all emails at
  # http://localhost:3000/rails/mailers/reader/cmd_mailer
  class ReplyMailerPreview < ActionMailer::Preview
    def help
      mailer.help(user)
    end

    def forum_news
      forum = Forum.all.sample
      mailer.forum_news(forum, feed_item)
    end

    def letter_with_news
      news = [
        { letter_item: LetterItem.first, feed_items: FeedItem.all },
        { letter_item: LetterItem.last, feed_items: FeedItem.all }
      ]

      mailer.letter_with_news(letter, news)
    end

    def selection
      mailer.selection(user, FeedItem.all, false)
    end

    def selection_plus
      mailer.selection(user, FeedItem.all, true)
    end

    private

    def mailer
      ReplyMailer
    end

    def user
      User.all.sample
    end

    def forum
      Forum.all.sample
    end

    def letter
      Letter.all.sample
    end

    def feed_item
      FeedItem.all.sample
    end
  end
end
