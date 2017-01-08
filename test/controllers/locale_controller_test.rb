require 'test_helper'

class LocaleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_locale = I18n.locale
  end

  teardown do
    I18n.locale = @current_locale
  end

  test 'should get change' do
    get change_locale_path(lang: APP::LANGS.shuffle.sample)
    assert_redirected_to root_path
  end
end
