unless defined?(Rails)
  require 'active_job'
  require 'sidekiq'

  require_relative '01_libs'

  Dir[File.expand_path('../../app/jobs/**/*.rb', __dir__)].sort
    .each { |f| require f }
end

ActiveJob::Base.queue_adapter = :sidekiq
