require 'test_helper'

module Utils
  class TokenizerTest < ActiveSupport::TestCase
    setup do
      @modul = Tokenizer
    end

    test '#gen_random_string' do
      token = modul.gen_random_string(modul::DEFAULT_SIZE)
      assert_equal token.size, modul::DEFAULT_SIZE
    end
  end
end
