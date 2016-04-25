require 'test_helper'

class AccountsHelperTest < ActionView::TestCase
  test '#register? => true' do
    params = { 'controller' => 'accounts', 'action' => %w(new create).sample }
    assert register?(params)
  end

  test '#register? => false' do
    params1 = { 'controller' => 'accounts', 'action' => 'edit' }
    params2 = { 'controller' => 'forums', 'action' => 'new' }

    assert_not register?(params1)
    assert_not register?(params2)
  end
end
