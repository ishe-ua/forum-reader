# coding: utf-8
# Базовый для всех mailer-ов.
#
class ApplicationMailer < ActionMailer::Base
  default from: "#{APP::NAME} <#{APP::NOREPLY_EMAIL}>"
  layout 'mailer'

  helper do
    def html_to_text(str)
      Nokogiri::HTML(str).text
    end
  end
end
