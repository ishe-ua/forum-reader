# Field +secret_name+ in table:
# * string
# * unique
# * not null
#
# Examples:
# * +secret_name+@example.com
# * +qweeeertrte+@example.com
# * +sds354drfsd+@example.com
#
module SecretName
  extend ActiveSupport::Concern

  SN_LENGTH = 18

  VALID_SN = /\A[a-z0-9]+\z/

  included do
    after_initialize :set_default_secret_name

    validates :secret_name,

              presence: true,
              uniqueness: true,

              format: { with: VALID_SN }
  end

  def secret_email
    secret_name + '@' + APP::HOST
  end

  def reset_secret_name
    new_sn = self.class.gen_random_secret_name
    update_attribute(:secret_name, new_sn)
  end

  class_methods do
    def secret_name_from(email)
      email.split('@').first
    end

    def gen_random_secret_name
      Utils::Tokenizer.gen_random_string(SN_LENGTH)
    end
  end

  protected

  def set_default_secret_name
    self.secret_name ||= self.class.gen_random_secret_name
  end
end
