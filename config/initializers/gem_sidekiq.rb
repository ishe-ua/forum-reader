require 'sidekiq'

redis_conn = proc { Redis.current }

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25 + 2, &redis_conn) # !! +2, see doc
end
