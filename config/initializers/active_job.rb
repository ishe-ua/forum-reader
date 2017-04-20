require 'active_job'
ActiveJob::Base.queue_adapter = :resque

unless defined?(Rails)
  require_relative '01_libs.rb'
  require_relative 'gem_redis.rb'
  require_relative 'gem_resque.rb'

  require_relative '../../app/jobs/application_job.rb'
  Dir[File.expand_path('../../app/jobs/**/*.rb', __dir__)]
    .sort
    .each { |f| require f }
end
