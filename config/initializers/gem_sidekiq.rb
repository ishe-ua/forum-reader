require 'sidekiq'
require_relative 'gem_redis.rb'

Sidekiq.configure_client do |config|
  config.redis = { url: redis.url }
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis.url }
end
