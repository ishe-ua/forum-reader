module Utils
  # Convert operations
  module Convert
    class << self
      def html_to_text(str)
        Nokogiri::HTML(str).text
      end
    end
  end
end
