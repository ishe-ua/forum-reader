module Utils
  # Token generator.
  module Tokenizer
    DEFAULT_SIZE = 24

    def self.gen_random_string(size = DEFAULT_SIZE)
      Array.new(size) { [*'0'..'9', *'a'..'z'].sample }.join
    end
  end
end
