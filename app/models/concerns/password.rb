# Field +password_digest+ in table:
# * string
#
module Password
  extend ActiveSupport::Concern

  MIN_PASSWORD = 5
  MAX_PASSWORD = 155

  included do
    has_secure_password

    validates :password,
              presence: true,

              length: { in: MIN_PASSWORD..MAX_PASSWORD },
              on: :create
  end

  class_methods do
    def generate_random_password
      Tokenizer.gen_random_string
    end
  end
end
