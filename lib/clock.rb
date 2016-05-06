require 'clockwork'
require 'active_job'

require './config/initializers/active_job'
require './config/initializers/gem_backburner'

Dir['./app/jobs/**/*.rb'].each do |f|
  require f
end

## App clock, gem 'clockwork'.
module Clockwork
  ## Always is UTC.
  TZ = 'UTC'.freeze

  LOG_DIR = './log'.freeze
  LOG_FILE = 'clockwork.log'.freeze

  configure do |config|
    config[:tz] = TZ
    config[:logger] = Logger.new("#{LOG_DIR}/#{LOG_FILE}") if Dir.exist? LOG_DIR
  end

  ###
  #
  #
end
