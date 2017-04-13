require 'sidekiq/api'

module Utils
  # Queue (Sidekiq) helpers.
  module Queues
    # Get batch of jobs from queue and process each one.
    def jobs_from(queue_name)
      q = Sidekiq::Queue.new(queue_name)
      q.each do |job|
        yield(job)
        job.delete
      end
    end

    def args_from(job)
      job.args
    end
  end
end
