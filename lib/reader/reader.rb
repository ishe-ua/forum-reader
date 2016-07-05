require_relative '../app.rb'

# RSS Reader
#
module Reader
  BOTE_NAME = 'reader'.freeze

  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  if defined?(Rails)
    require_relative 'cmd.rb' # should be first
    require_relative 'bote_in.rb'
    require_relative 'bote_out.rb'
    require_relative 'fetcher.rb'
    require_relative 'sender.rb'
  end
end
