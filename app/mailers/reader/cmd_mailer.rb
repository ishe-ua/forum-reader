module Reader
  # Replies to Cmd -commands.
  class CmdMailer < ApplicationMailer
    layout 'mailer_no_regards'

    # Reply to Cmd::HelpJob
    def help(user)
      I18n.with_locale(user.lang) { mail(to: user.jabber) }
    end

    # Forum news to Target :
    #
    # 1. +html+ version to Email
    # 2. +text+ version to Jabber

    def forum_news(forum, feed_item, target)
      @target = target
      @feed_item = feed_item

      to = target == :jabber ? forum.user.jabber : forum.user.account.email

      mail to: to,
           subject: build_subject(forum.name, feed_item.theme)
    end

    # Letter with news to Email.
    #
    # News is array of hashes like [{letter_item: x, feed_items: y}, ...]

    def letter_with_news(letter, news)
      @news = news
      mail(to: letter.user.account.email,
           subject: build_subject(APP::NAME, letter.name)) do |format|
        format.html { render layout: 'mailer' }
        format.text { render layout: 'mailer' }
      end
    end

    private

    def build_subject(prefix, text)
      @subject = "[#{prefix}]: #{text}"
    end
  end
end
