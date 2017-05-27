require 'clockwork'
require_relative '../config/initializers/action_mailer'
require_relative '../config/initializers/active_job'

# App clock, gem 'clockwork'.
module Clockwork
  # Time for system tasks.
  SYS_TIME = '4:00'.freeze

  LOG_DIR = './log'.freeze

  LOG_FILE = 'clockwork.log'.freeze

  configure do |config|
    config[:logger] = Logger.new("#{LOG_DIR}/#{LOG_FILE}") if
      Dir.exist?(LOG_DIR)
  end

  every(1.week, 'Run system tasks', at: 'Friday 15:20') do
    AdminMailer.stats.deliver_later
  end

  # every(1.day, 'Run system tasks', at: SYS_TIME) {}

  every(1.minute, 'reader: send letters', if: lambda { |time|
    APP::SUPPORTED_MINUTES.include?(time.min)
  }) do
    Reader::SendLettersJob.perform_later(Time.now.utc.to_i)
  end

  every(5.minutes, 'reader: fetch feeds') do
    Reader::FetchFeedsJob.perform_later
  end
end
