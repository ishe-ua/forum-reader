# RSS Reader.
#
# Parts:
#
# 1. Fetcher
# 2. BoteIn
# 3. BoteOut
#
module Reader
  require_relative 'fetcher.rb'
  require_relative 'bote_in.rb'
  require_relative 'bote_out.rb'


  BOTE_NAME = 'reader'.freeze
  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  DEFAULT_SELECTION_SIZE = 5
end
