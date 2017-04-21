require 'resque'
Resque.redis = Redis.current

# if defined?(Rails) && (
#      !Rails.env.development? && !Rails.env.test?)

#   Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))
# end
