require 'capybara/rails'
require 'capybara/poltergeist'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end

Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

## On js-mode
def js
  Capybara.current_driver =
    Capybara.javascript_driver
end

## Off js-mode
def js_off
  Capybara.reset_sessions!
  Capybara.use_default_driver
end
