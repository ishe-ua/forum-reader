require 'backburner'

## App helpers.
module Helpers
  extend Backburner::Helpers

  # Get access to Beanstalkd tube.
  def self.get_tube(name)
    conn = Backburner::Connection.new(Backburner.configuration.beanstalk_url)
    tube = conn.tubes[expand_tube_name(name)]
    tube
  end
end
