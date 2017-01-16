RAILS_ROOT = File.expand_path('..', __dir__)
require_relative '../lib/app.rb'

God.watch do |w|
  w.name  = APP::NAME + '-web'
  w.start = 'bundle exec puma'

  w.keepalive
  w.group = 'web'

  w.dir = RAILS_ROOT
  w.env = { 'RAILS_ENV' => 'production' }
end
