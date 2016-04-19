# coding: utf-8
require 'test_helper'

class ReaderSetTest < ActiveSupport::TestCase
  setup do
    @instance = reader_sets(:mary)
  end

  include ValidateInstanceTest
  include ValidateFixturesTest
end
