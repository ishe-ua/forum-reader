# coding: utf-8
require 'test_helper'

class ChangeStatusesTest < ActionDispatch::IntegrationTest
  setup do
    sign_in(accounts(:ishe))
  end

  test 'from on to off' do
    visit data_path

    within('.status.reader') do
      assert page.has_text?('ON')
      click_link(I18n.t(:change))
      assert page.has_text?('OFF')
    end
  end

  test 'from off to on' do
    mailer_sets(:ishe).update(status: Status::STATUS_OFF)
    visit data_path

    within('.status.mailer') do
      assert page.has_text?('OFF')
      click_link(I18n.t(:change))
      assert page.has_text?('ON')
    end
  end
end
