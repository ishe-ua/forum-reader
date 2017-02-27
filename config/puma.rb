require_relative '../lib/app.rb'

threads_count = 1
threads threads_count, threads_count

bind "unix:/tmp/#{APP::NAME.tr('-', '_')}.sock"
environment ENV.fetch('RAILS_ENV') { 'development' }

workers ENV.fetch('WEB_CONCURRENCY') { 2 }
preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
