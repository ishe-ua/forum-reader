unless defined?(Rails)
  require 'active_job'
  require 'sidekiq'

  # TODO: require_relative '../../lib/utils/queues.rb'
  Dir[File.expand_path('../../app/jobs/**/*.rb', __dir__)]
    .each { |f| require f }
end

ActiveJob::Base.queue_adapter = :sidekiq
