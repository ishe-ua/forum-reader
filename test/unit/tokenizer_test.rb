require 'test_helper'

class TokenizerTest < ActiveSupport::TestCase
  setup do
    @modul = Tokenizer
  end

  test '#random_string' do
    token = modul.random_string(48)
    assert_equal token.size, 48
  end
end
