# coding: utf-8
require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create contact and send 2 emails' do
    assert_difference('Contact.count') do
      assert_enqueued_jobs 2 do
        post :create, contact:
                        {
                          email: 'user@example.com',
                          theme: 'aa',
                          text:  'bb'
                        }
      end

      assert_response :redirect
      assert_redirected_to pages_info_path
    end
  end

  test 'should not create contact if заполнены не все поля, письма не шлются' do
    assert_no_difference('Contact.count') do
      assert_no_enqueued_jobs do # письма не шлются через .deliver_later
        assert_no_emails do      # письма не шлются через .deliver_later
          post :create, contact:
                          {
                            email: 'user@example.com',
                            theme: '',
                            text:  ''
                          }

          assert_response :success
        end
      end
    end
  end
end
