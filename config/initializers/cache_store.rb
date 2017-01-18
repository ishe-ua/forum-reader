# Be sure to restart your server when you modify this file.

if !Rails.env.development? && !Rails.env.test?
  opts = Rails.application
              .config_for(:redis).merge(namespace: '_reader_cache')

  Rails.application
       .config
       .cache_store = :redis_store, opts, { expires_in: 1.week }
end
