module Reader
  # Run Cleaner.
  class CleanerJob < ActiveJob::Base
    queue_as :default

    def perform
      Cleaner.run
    end
  end
end
