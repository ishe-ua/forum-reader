# coding: utf-8
# frozen_string_literal: true
require 'clockwork'
require 'active_job'

# require './config/initializers/active_job'
# require './config/initializers/gem_backburner'

Dir['./app/jobs/**/*.rb'].each do |f|
  require f
end

##
# <b>"Часики"</b> проекта.
#
# Запускают задачки по рассписанию.
#
module Clockwork
  ## Временная зона "часиков", все время выставляется в ней.
  TZ = 'Kyiv'.freeze

  ## Каталог log-файла.
  LOG_DIR = './log'.freeze

  ## Назва log-файла.
  LOG_FILE = 'clockwork.log'.freeze

  configure do |config|
    config[:tz] = TZ
    config[:logger] = Logger.new("#{LOG_DIR}/#{LOG_FILE}") if
      Dir.exist?(LOG_DIR)
  end

  ###
  #
  #
end
