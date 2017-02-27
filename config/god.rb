RAILS_ROOT = File.expand_path('..', __dir__)
RAILS_ENV = { 'RAILS_ENV' => 'production' }.freeze

God.watch do |w|
  w.name  = 'web'
  w.start = 'bundle exec puma'

  w.keepalive

  w.dir = RAILS_ROOT
  w.env = RAILS_ENV
end

# God.watch do |w|
#   w.name  = 'clock'
#   w.start = 'bundle exec clockwork lib/clock.rb'

#   w.keepalive

#   w.dir = RAILS_ROOT
#   w.env = RAILS_ENV
# end
