require 'resque'
Resque.redis = Redis.current

# if defined?(Rails) && (
#      !Rails.env.development? && !Rails.env.test?)

#   log_file = Rails.root.join('log', "#{Rails.env}_resque.log")
#   Resque.logger = Logger.new(log_file)
# end
