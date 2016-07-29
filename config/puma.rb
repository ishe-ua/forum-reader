# gem 'puma'
#

workers Integer(ENV['WEB_WORKERS'] || 1)
threads 1, 1

preload_app!
rackup DefaultRackup
environment ENV['RACK_ENV'] || 'development'

bind 'unix:/tmp/forum-reader.sock'

before_fork do
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
