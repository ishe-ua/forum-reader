require 'active_job'
ActiveJob::Base.queue_adapter = :sidekiq

unless defined?(Rails)
  require_relative '../../lib/app.rb'
  require_relative 'gem_redis.rb'
  require_relative 'gem_sidekiq.rb'

  require_relative '../../app/jobs/application_job.rb'
  Dir[File.expand_path('../../app/jobs/**/*.rb', __dir__)]
    .sort
    .each { |f| require f }
end
