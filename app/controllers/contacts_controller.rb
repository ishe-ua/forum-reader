# coding: utf-8
# Морда для Contact.
#
class ContactsController < ApplicationController
  skip_before_action :require_sign_in

  ##
  # GET /contacts/new
  #
  # Показать форму.
  #

  def new
    @contact = Contact.new
  end

  ##
  # POST /contacts
  #
  # Создать.
  #
  # Если все хорошо - отправляются ContactsMailer -письма.
  #

  def create
    @contact = Contact.new(contact_params)
    # TODO: каптча

    respond_to do |format|
      if @contact.save
        format.html { send_emails_and_redirect_to_info }
      else
        format.html { render :new }
      end
    end
  end

  private

  def contact_params
    params.require(:contact)
          .permit(
            :email,
            :theme,
            :text
          )
  end

  def send_emails_and_redirect_to_info
    ContactsMailer.to_us(@contact).deliver_later(queue_priority: 0)
    ContactsMailer.thank_you(@contact).deliver_later(queue_priority: 0)

    redirect_to pages_info_path, notice: t('thank_you')
  end
end
