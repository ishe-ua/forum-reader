module Mailer
  # Income (receive) email from Piper.
  class IncomeEmailJob < ApplicationJob
    queue_as :default

    # See Piper#to
    MAX_BODY = 1024

    # Limited by Postgres String type
    MAX_SUBJECT = 256

    # Params: see Piper protected methods
    def perform(from, to, subject, body, attachments)
      raise_unless_array(to)
      return unless (user = find_whom_by_secret_name(to))

      msg = create_message(user, from, subject, body, attachments)
      ReplyJob.perform_later(msg) if msg
    end

    protected

    def raise_unless_array(to)
      raise 'To should be array' unless to.is_a?(Array)
    end

    # See SecretName
    def find_whom_by_secret_name(to)
      user = nil
      to.each do |email|
        secret_name = email.split('@')[0].strip.downcase
        user = MailerSet.find_by(secret_name: secret_name)
        break if user
      end

      user
    end

    # See Message
    def create_message(user, from, subject, body, attachments)
      user.messages
          .create(from: from,
                  subject: subject,
                  body: body,
                  attachments: attachments)
    end
  end
end
