# coding: utf-8
# Письма для ContactsController#create.
#
class ContactsMailer < ApplicationMailer
  ##
  # Спасибо что оставили сообщение (письмо от нас пользователю).
  #
  # Если Account с таким email имеется - шлем письмо в его локали,
  # иначе - в дефолтной.
  #

  def thank_you(contact)
    @contact = contact

    account = Account.find_by(email: contact.email)
    l = account ? account.lang : I18n.default_locale

    I18n.with_locale(l) do
      mail to: @contact.email, subject: t('thank_you')
    end
  end

  ## Вопрос от пользователя нам на ящик.
  def to_us(contact)
    @contact = contact
    mail to: APP::ADMIN_EMAIL, subject: 'НАПИСАТЬ НАМ от пользователя'
  end
end
