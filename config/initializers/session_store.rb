# Be sure to restart your server when you modify this file.

key = '_reader_session'
cfg = Rails.application.config

if Rails.env.development? || Rails.env.test?
  cfg.session_store :cookie_store, key: key
else
  opts = Rails.application.config_for(:redis).merge(namespace: key)
  cfg.session_store :redis_store, servers: opts, expires_in: 1.year
end
