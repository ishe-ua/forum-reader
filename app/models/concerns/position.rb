# gem 'acts_as_list'
#
# Field +position+ in table:
# * integer
#
module Position
  extend ActiveSupport::Concern

  included do
    default_scope { order :position }
  end

  # TODO: set default value to 1
end
