# Email to Jabber notifications.
#
module Mailer
  BOTE_NAME = 'mailer'.freeze

  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  require_relative 'piper.rb'
end
