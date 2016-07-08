# See AccountsController.
module AccountsHelper
  # Register new User operation?
  def register?(params)
    c = params['controller']
    a = params['action']

    c == 'accounts' && (a == 'new' || a == 'create')
  end
end
