require_relative '../config/initializers/active_job'
require 'clockwork'

# App clock, gem 'clockwork'.
module Clockwork
  # Always is UTC.
  TZ = 'UTC'.freeze

  LOG_DIR = './log'.freeze
  LOG_FILE = 'clock.log'.freeze

  # Time for system tasks.
  SYS_TIME = '4:05'.freeze

  configure do |config|
    config[:tz] = TZ
    config[:logger] = Logger.new("#{LOG_DIR}/#{LOG_FILE}") if Dir.exist? LOG_DIR
  end

  # rubocop:disable LineLength
  # rubocop:disable Rails/TimeZone

  every(5.minutes, 'reader.fetch.forums') { Reader::FetchForumsJob.perform_later }
  every(15.minutes, 'reader.fetch.letters') { Reader::FetchLettersJob.perform_later }
  every(1.minute, 'reader.send_letters') { Reader::SendLettersJob.perform_later(Time.now) }
  every(1.day, 'reader.clean_feed_items', at: SYS_TIME) { Reader::CleanerJob.perform_later }
end
