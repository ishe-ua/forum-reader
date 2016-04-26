# coding: utf-8
require 'test_helper'

class MoverTest < ActionController::TestCase
  tests ForumsController

  setup do
    sign_in(accounts(:ishe))
  end

  # TODO
end
