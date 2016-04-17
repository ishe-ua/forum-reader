require 'test_helper'

class TokenizerTest < ActiveSupport::TestCase
  setup do
    @modul = Tokenizer
  end

  test '#random_string' do
    token = modul.random_string(modul::DEFAULT_SIZE)
    assert_equal token.size, modul::DEFAULT_SIZE
  end
end
