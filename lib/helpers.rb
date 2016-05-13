require 'backburner'
require 'zlib'

# Queues (beanstalkd) helpers.
module Helpers
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

    # Make smaller string size (before enqueue):
    # 1. Job size is limited
    # 2. String from external Feed can have bad encoding
    def compress(string)
      Zlib::Deflate.deflate(string)
    end

    # Opposite of ::compress.
    def decompress(string)
      Zlib::Inflate.inflate(string)
    end
  end
end
