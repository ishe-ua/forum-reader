require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_contact_path
    assert_response :success
  end

  test 'should create contact and send 2 emails' do
    assert_difference('Contact.count') do
      assert_enqueued_emails 2 do
        post contacts_path, params: { contact:
                                        {
                                          email: 'user@example.com',
                                          theme: 'aa',
                                          text:  'bb'
                                        } }
      end

      assert_redirected_to info_path
    end
  end

  test 'should not create contact if some fields are empty' do
    assert_no_difference('Contact.count') do
      assert_no_enqueued_emails
      assert_no_emails do
        post contacts_path, params: {
               contact:
                 {
                   email: 'user@example.com',
                   theme: '',
                   text:  ''
                 }
             }

        assert_response :success
      end
    end
  end
end
