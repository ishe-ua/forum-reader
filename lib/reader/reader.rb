require_relative '../app.rb'

# RSS Reader.
#
# Parts:
#
# 1. Fetcher
# 2. BoteIn
# 3. BoteOut
# 4. CleanerJob
#
module Reader
  BOTE_NAME = 'reader'.freeze

  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  BOTE_PASSWORD = ENV['reader_bote_password']

  if defined?(Rails)
    require_relative 'fetcher.rb'
    require_relative 'bote_in.rb'
    require_relative 'bote_out.rb'
  end

  DEFAULT_SELECTION_SIZE = 5

  MAX_SELECTION_SIZE = 200
end
