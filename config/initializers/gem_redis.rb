require 'redis'

env = if defined?(Rails)
        Rails.env
      else
        ENV.fetch('RAILS_ENV') { 'production' }
      end

opts = YAML.load_file('config/redis.yml')[env].symbolize_keys
Redis.current = Redis.new(opts)

# Alias
def redis
  Redis.current
end
