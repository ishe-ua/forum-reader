require 'test_helper'

module Reader
  class FetcherTest < ActiveSupport::TestCase
    setup do
      @modul = Fetcher
    end

    test 'run' do
      modul.respond_to?(:run)
    end

    test 'process_incoming' do
      modul.respond_to?(:process_incoming)
    end
  end
end
