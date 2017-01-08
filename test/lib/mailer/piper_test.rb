require 'test_helper'

module Mailer
  class PiperTest < ActiveSupport::TestCase
    setup do
      @mail = sample_mail
      @instance = Piper.new(@mail)
    end

    test 'truth' do
      skip
    end

    test 'max body size defined' do
      assert_equal(
        instance.send(:max_body),
        IncomeEmailJob::MAX_BODY
      )
    end

    private

    def sample_mail(opts = {})
      Mail.new do
        from     opts[:from] || 'user@example.com'
        to       opts[:to]   || "j4827rb1ua@#{APP::HOST}"
        subject 'Hello, guys!!'
        body    'Thank you!!'
      end
    end
  end
end
