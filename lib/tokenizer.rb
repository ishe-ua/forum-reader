# Token generator.
module Tokenizer
  DEFAULT_SIZE = 24

  def self.gen_random_string(size = DEFAULT_SIZE)
    chars = ('a'..'z').to_a.shuffle
    nums = (0..9).to_a.shuffle

    ar = (chars + nums).shuffle
    1.upto(size).map { ar.sample }.join
  end
end
