# coding: utf-8
# Хелперы для AccountsController.
#
module AccountsHelper
  ## Это операция регистрации аккаунта?
  def register?(params)
    c = params['controller']
    a = params['action']

    c == 'accounts' && (a == 'new' || a == 'create')
  end
end
