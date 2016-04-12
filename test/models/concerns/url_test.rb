# coding: utf-8
require 'test_helper'

class TimezoneTest < ActiveSupport::TestCase
  setup do
    @instance = build([:forum, :letter_item].shuffle.sample)
  end

  test 'обязательное поле' do
    instance.url = nil
    assert_not instance.valid?
  end

  test 'невалидный url автоматом превращается в валидный' do
    skip
    instance.url = 'xx'
    instance.save!
    assert_equal instance.reload.url, 'http://xx'
  end

  # context "всегда в нижнем регистре" do
  #   before { @url = 'HTTP://EXample.cOm/feEEd' }

  #   it "при создании нового"        do subj.url = @url; end
  #   it "при обновлении имеющегося"  do assert subj.save; subj.url = @url; end

  #   after do
  #     assert subj.save
  #     assert_equal subj.url, @url.downcase
  #   end
  # end

  # context "http/https - если без них, то подсовывается автоматом http" do
  #   after do
  #     subj.url = @url_before
  #     subj.save
  #     assert_equal subj.reload.url, @url_after
  #   end

  #   it "надо подсунуть" do
  #     @url_before = 'example.com/RSS'
  #     @url_after  = 'http://example.com/rss'
  #   end

  #   it "не надо - уже есть http" do
  #     @url_before = 'http://example.com/RSS'
  #     @url_after  = 'http://example.com/rss'
  #   end

  #   it "не надо - уже есть https" do
  #     @url_before = 'httpS://example.com/RSS'
  #     @url_after  = 'https://example.com/rss'
  #   end
  # end
end
