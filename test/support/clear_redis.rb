# Clear (flush) redis db
def clear_redis
  redis.flushdb
end
