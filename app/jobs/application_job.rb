# Base job.
class ApplicationJob < ActiveJob::Base
  # From README.md of gem 'resque'
  before_perform do |_job|
    ActiveRecord::Base.clear_active_connections!
  end
end
