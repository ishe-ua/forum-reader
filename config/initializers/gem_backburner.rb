require 'backburner'

raise 'ExceptionNotifier not defined' if
  defined?(Rails) && !defined?(ExceptionNotifier)

Backburner.configure do |config|
  config.beanstalk_url    = ['beanstalk://127.0.0.1']
  config.tube_namespace   = APP::NAME
  config.primary_queue    = 'default'
  config.max_job_retries  = 3
  config.retry_delay      = 5
  config.default_priority = 65_536
  config.respond_timeout  = 120
  config.default_worker   = Backburner::Workers::Simple
  config.reserve_timeout  = nil

  config.on_error = lambda { |e|
    ExceptionNotifier.notify_exception(e) if defined?(Rails)
  }

  config.logger = Logger.new('./log/backburner.log') if
    Dir.exist?('./log')

  # config.priority_labels  = { custom: 50, useless: 1000 }
end
