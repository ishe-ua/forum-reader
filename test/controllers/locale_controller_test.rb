require 'test_helper'

class LocaleControllerTest < ActionController::TestCase
  setup do
    @current_locale = I18n.locale
  end

  teardown do
    I18n.locale = @current_locale
  end

  test "should get change" do
    get :change, lang: APP::LANGS.shuffle.sample
    assert_response :redirect
  end
end
