require 'backburner'

module Utils
  # Queues (beanstalkd) helpers.
  module Queues
    extend Backburner::Helpers

    class << self
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
    end
  end
end
