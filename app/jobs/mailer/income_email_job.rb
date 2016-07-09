module Mailer
  # Income email from MTA.
  #
  # See Piper.
  class IncomeEmailJob < ActiveJob::Base
    queue_as :default

    # See Piper#to
    MAX_BODY = 1024

    def perform(from, to, subject, body, attaches)
      # TODO
    end
  end
end
