unless defined?(Rails)
  require 'active_job'
  require_relative 'gem_backburner'

  require_relative '../../lib/utils/queues.rb'
  Dir['../../app/jobs/**/*.rb'].each { |f| require f }
end

ActiveJob::Base.queue_adapter = :backburner
