module Reader
  # Preview all emails at
  # http://localhost:3000/rails/mailers/reader/cmd_mailer
  class CmdMailerPreview < ActionMailer::Preview
    def help
      mailer.help(user)
    end

    def forum_news
      mailer.forum_news(forum, feed_item, target)
    end

    def letter_with_news
      news = [
        { letter_item: LetterItem.first, feed_items: FeedItem.all },
        { letter_item: LetterItem.last, feed_items: FeedItem.all }
      ]

      mailer.letter_with_news(letter, news)
    end

    private

    def mailer
      CmdMailer
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

    def target
      Target::SUPPORTED_TARGETS.sample.to_sym
    end
  end
end
