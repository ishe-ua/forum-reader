require_relative '../config/initializers/active_job'
require 'clockwork'

## App clock, gem 'clockwork'.
module Clockwork
  ## Always is UTC.
  TZ = 'UTC'.freeze

  LOG_DIR = './log'.freeze
  LOG_FILE = 'clock.log'.freeze

  configure do |config|
    config[:tz] = TZ
    config[:logger] = Logger.new("#{LOG_DIR}/#{LOG_FILE}") if Dir.exist? LOG_DIR
  end

  every(5.minutes, 'fetch.forums') { Reader::FetchForumsJob.perform_later }
  every(15.minutes, 'fetch.letters') { Reader::FetchLettersJob.perform_later }
end
