module Reader
  # Run Cleaner.
  class CleanerJob < ActiveJob::Base
    queue_as :default

    def perform
      Cleaner.clean
    end
  end
end
