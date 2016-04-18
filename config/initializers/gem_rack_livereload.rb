# coding: utf-8
# gem 'rack-livereload'
#

if Rails.env.development?
  Rails.application
       .config
       .middleware.insert_after(ActionDispatch::Static, Rack::LiveReload)
end
