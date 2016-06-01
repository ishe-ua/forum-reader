module Reader
  # Preview all emails at
  # http://localhost:3000/rails/mailers/reader/cmd_mailer
  class CmdMailerPreview < ActionMailer::Preview
    def help
      mailer.help(user)
    end

    private

    def mailer
      CmdMailer
    end

    def user
      User.all.sample
    end
  end
end
