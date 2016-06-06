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

    def feed_item
      FeedItem.all.sample
    end

    def target
      Target::SUPPORTED_TARGETS.sample.to_sym
    end
  end
end
