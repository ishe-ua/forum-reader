require 'test_helper'

module Reader
  class ReaderTest < ActiveSupport::TestCase
    setup do
      @modul = Reader
    end

    test 'check bote name' do
      assert_equal modul::BOTE_JID, 'reader@forum-reader2.com'
    end
  end
end
