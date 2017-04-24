module Reader
  # Replies to Cmd -commands.
  class ReplyMailer < ApplicationMailer
    layout 'mailer_no_regards'

    # Reply to Cmd::HelpJob
    def help(user)
      I18n.with_locale(user.lang) { mail(to: user.jabber) }
    end

    # Forum news to Target :
    #
    # 1. +html+ version to Email
    # 2. +text+ version to Jabber

    def forum_news(forum, feed_item)
      @forum = forum
      @feed_item = feed_item

      to = forum.user.account.email  if forum.email?
      to = forum.user        .jabber if forum.jabber?

      mail(to: to, subject: build_subject(forum.name, feed_item.theme))
    end

    # Letter with news to Email.
    #
    # News is array of hashes like
    # [[letter_item_id, feed_items_ids], ...]

    def letter_with_news(letter, news)
      @news = news
      mail(to: letter.user.account.email,
           subject: build_subject(APP::NAME, letter.name)) do |format|
        format.html { render layout: 'mailer' }
        format.text { render layout: 'mailer' }
      end
    end

    # FeedItem selection to Jabber.
    #
    # See Cmd::LastJob and Cmd::ListJob

    def selection(user, feed_items, plus)
      @feed_items = feed_items
      @plus = plus
      mail(to: user.jabber)
    end

    private

    def build_subject(prefix, text)
      @subject = "[#{prefix}]: #{text}"
    end
  end
end
