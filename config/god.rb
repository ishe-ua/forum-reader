require_relative '../lib/app.rb'
RAILS_ROOT = File.dirname(File.dirname(__FILE__))


God.watch do |w|
  w.name = APP::NAME + '-web'
  w.dir = RAILS_ROOT

  # pid_file = File.join(RAILS_ROOT, 'tmp/puma.pid')

  # w.pid_file = pid_file
  # w.behavior(:clean_pid_file)

  w.start = 'bundle exec puma'
  # w.stop = "kill -s QUIT $(cat #{pid_file})"
  # w.restart = "kill -s HUP $(cat #{pid_file})"

  w.interval = 10.seconds
  w.start_grace = 20.seconds
  w.restart_grace = 20.seconds

  w.env = { 'RAILS_ENV' => 'production' }
end
