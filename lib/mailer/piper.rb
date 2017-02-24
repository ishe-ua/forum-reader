module Mailer
  # Income emails from Postfix.
  #
  # <tt>bin/pipe</tt> - pipe-script for Postfix [http://postfix.org/pipe.8.html]
  #
  class Piper
    # See config/initializers/lib_piper.rb
    REQUIRED_LIBS = %w(active_job mail).each { |lib| require lib }

    require_relative '../../config/initializers/active_job'
    # FIX: require_relative '../../config/initializers/gem_backburner'

    require_relative '../app'
    require_relative '../../app/jobs/mailer/income_email_job'

    # Incoming email.
    #
    # Some restrictions in Postfix config.

    attr_reader :mail

    # Compose #mail from Postfix.
    def initialize(mail_from_stream)
      @mail = Mail.read_from_string(mail_from_stream)
      raise 'Mail compose error' unless @mail
    end

    # Redirect #mail <tt>from Postfix to Rails</tt>.
    #
    # Compose IncomeEmailJob.

    def forward
      IncomeEmailJob.perform_later(from, to, subject, body, attachments) if mail
    end

    protected

    def from
      mail.from.first
          .downcase
          .strip
    end

    # Return list of emails
    def to
      count = mail.to.count
      count > 1 ? mail.to : [mail.to]
    end

    def subject
      s = (mail.subject || '').strip
      s.size > max_subject ? (b[0..(max_subject - 3)] + '...') : b
    end

    def body
      b = (mail.body.decoded || '').strip
      b.size > max_body ? (b[0..(max_body - 3)] + '...') : b
    end

    # Return string like '1.txt, 2.txt'
    def attachments
      mail.attachments.map(&:filename).join(', ')
    end

    private

    def max_body
      IncomeEmailJob::MAX_BODY
    end

    def max_subject
      IncomeEmailJob::MAX_SUBJECT
    end
  end
end
