# Preview all emails at http://localhost:3000/rails/mailers/reader/cmd_mailer
class Reader::CmdMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reader/cmd_mailer/help
  def help
    Reader::CmdMailer.help
  end

end
