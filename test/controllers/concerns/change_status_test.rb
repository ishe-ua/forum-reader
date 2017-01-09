require 'test_helper'

class ChangeStatusTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:ishe)
    sign_in(@account)
  end

  test '#success' do
    resource = [@account.user.reader_set, @account.user.mailer_set].sample
    patch change_status_reader_path(id: resource, format: :js)
    assert_response :success
  end
end
