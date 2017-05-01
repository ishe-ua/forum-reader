require_relative '../lib/app.rb'

threads_count = 1
threads threads_count, threads_count

if defined?(Rails) && Rails.env.development?
  port ENV.fetch('PORT') { 3000 }
else
  bind "unix:/tmp/#{APP::NAME.tr('-', '_')}.sock"
end

environment ENV.fetch('RAILS_ENV') { 'development' }

# workers ENV.fetch('WEB_CONCURRENCY') { 1 }
# preload_app!

# on_worker_boot do
#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
# end

# Allow puma to be restarted by `rails restart` command.
# plugin :tmp_restart
