# coding: utf-8
require 'test_helper'

class ChangeStatusTest < ActionController::TestCase
  tests [ReaderSetsController, MailerSetsController].shuffle.sample

  setup do
  end
end
