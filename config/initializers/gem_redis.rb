require 'redis'
require 'yaml'

env = if defined?(Rails)
        Rails.env
      else
        ENV.fetch('RAILS_ENV') { 'production' }
      end

opts = YAML.load_file('config/redis.yml')[env]
Redis.current = Redis.new(opts)

# Alias
def redis
  Redis.current
end

# Get redis url
def redis_url
  "redis://#{redis.client.host}:#{redis.client.port}/#{redis.client.db}"
end
