require 'backburner'

module Utils
  # Queues (beanstalkd) helpers.
  module Queues
    extend Backburner::Helpers

    # Get access to Beanstalkd tube.
    def get_tube(name)
      conn = Backburner::Connection.new(Backburner.configuration.beanstalk_url)
      tube = conn.tubes[expand_tube_name(name)]
      tube
    end

    # Get job arguments from Beaneater::Job.
    #
    # Example:
    # url = Helpers.args_from(job).first

    def args_from(job)
      raise 'left class' unless job.is_a?(Beaneater::Job)
      JSON.parse(job.body)['args'].first['arguments']
    end

    # Get batch of jobs from tube and process each.
    #
    # Cache #get_tube is present.

    def jobs_from(tube_name)
      @tube ||= get_tube(tube_name)
      while @tube.peek(:ready)
        job = @tube.reserve
        yield(job)
        job.delete
      end
    end
  end
end
