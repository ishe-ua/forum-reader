# coding: utf-8
# Базовый для всех mailer-ов.
#
class ApplicationMailer < ActionMailer::Base
  default from: "#{APP::NAME} <#{APP::NOREPLY_EMAIL}>"
  layout 'mailer'
end
