# rubocop:disable GlobalVars

def connect_to_redis
  return if $redis&.connected?
  $redis = Redis.new(Rails.application.config_for(:redis))
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
