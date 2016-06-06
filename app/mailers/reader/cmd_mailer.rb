module Reader
  # Replies to Cmd -commands.
  class CmdMailer < ApplicationMailer
    # Reply to Cmd::HelpJob
    def help(user)
      I18n.with_locale(user.lang) { mail(to: user.jabber) }
    end

    # Send Forum news to Target :
    #
    # 1. +html+ version to Email
    # 2. +text+ version to Jabber

    def forum_news(forum, feed_item, target)
      @target = target
      @feed_item = feed_item

      to = target == :jabber ? forum.user.jabber : forum.user.account.email
      mail to: to,
           subject: (@subject = "[#{forum.name}]: #{feed_item.theme}")
    end
  end
end
