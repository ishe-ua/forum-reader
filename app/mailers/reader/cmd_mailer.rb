module Reader
  # Replies to Cmd -commands.
  class CmdMailer < ApplicationMailer
    # Reply to Cmd::HelpJob
    def help(user)
      I18n.with_locale(user.lang) { mail(to: user.jabber) }
    end
  end
end
