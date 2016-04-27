# coding: utf-8
# gem 'rack_session_access'
#

if Rails.env.test?
  Rails.application
       .config
       .middleware.use(RackSessionAccess::Middleware)
end
