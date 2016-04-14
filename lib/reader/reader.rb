# coding: utf-8
# RSS Reader.
#
module Reader
  Dir[].each { |f| require f }

  ## Назва бота.
  BOTE_NAME = 'reader'.freeze

  ## JID бота.
  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  ## сколько новостей выдает по дефолту.
  DEFAULT_SELECTION_SIZE = 5
end
