module Reader
  # Run Cleaner.
  #
  # Clockwork task
  class CleanerJob < ActiveJob::Base
    queue_as :default

    def perform
      Cleaner.clean
    end
  end
end
