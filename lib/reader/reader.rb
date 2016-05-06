# RSS Reader.
#
module Reader
  Dir[Rails.root.join('lib/reader/fetcher/*.rb')].each { |f| require f }
  extend Fetcher

  BOTE_NAME = 'reader'.freeze

  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  DEFAULT_SELECTION_SIZE = 5
end
