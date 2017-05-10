require 'test_helper'
require 'capybara/poltergeist'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :poltergeist, screen_size: [1400, 1400]

  def sign_in(account = accounts(:ishe))
    visit login_url

    fill_in Account.human_attribute_name(:email),    with: account.email
    fill_in Account.human_attribute_name(:password), with: APP::DEFAULT_PASSWORD

    click_button I18n.t('form.submit')
    assert_equal current_path, data_path
  end

  def sign_out
    visit logout_url
  end
end
