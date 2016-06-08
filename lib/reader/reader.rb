require_relative '../app.rb'

# RSS Reader.
#
# Parts:
#
# 1. Fetcher
# 2. BoteIn
# 3. BoteOut
# 4. CleanerJob
# 5. Cmd
#
module Reader
  BOTE_NAME = 'reader'.freeze

  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  if defined?(Rails)
    require_relative 'fetcher.rb'
    require_relative 'bote_in.rb'
    require_relative 'bote_out.rb'
    require_relative 'cmd.rb'
  end
end
