# coding: utf-8
require 'test_helper'

class ChangeStatusesTest < ActionDispatch::IntegrationTest
  setup do
    reader_sets(:ishe).update(status: Status::ON)
    mailer_sets(:ishe).update(status: Status::OFF)

    sign_in(accounts(:ishe))
    visit data_path
  end

  test 'from on to off' do
    within('.status.reader') do
      assert page.has_text?(on)
      click_link(I18n.t(:change))
      assert page.has_text?(off)
    end
  end

  test 'from off to on' do
    within('.status.mailer') do
      assert page.has_text?(off)
      click_link(I18n.t(:change))
      assert page.has_text?(on)
    end
  end

  private

  def on
    Status::ON.upcase
  end

  def off
    Status::OFF.upcase
  end
end
