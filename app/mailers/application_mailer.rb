# Base Mailer
class ApplicationMailer < ActionMailer::Base
  default from: "#{APP::NAME} <#{APP::NOREPLY_EMAIL}>"
  layout 'mailer'

  helper do
    def html_to_text(str)
      Utils::Convert.html_to_text(str)
    end
  end
end
