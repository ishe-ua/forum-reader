module Reader
  # Send Letter -s by schedule.
  #
  # Clockwork task
  class SendLettersJob < ApplicationJob
    queue_as :default

    def perform(enqueue_time)
      return unless fifth_minute?(enqueue_time)
      # TODO
    end

    protected

    # See Schedule
    def fifth_minute?(time)
      Schedule::SUPPORTED_MINUTES.include?(time.min)
    end
  end
end
