require 'redis'

# rubocop:disable GlobalVars
def connect_to_redis
  return if $redis&.connected?
  $redis = if defined?(Rails)
             Redis.new(Rails.application.config_for(:redis))
           else
             Redis.new # TODO
           end
end

connect_to_redis

# Get Redis connection
def redis
  $redis
rescue
  connect_to_redis
ensure
  $redis
end
