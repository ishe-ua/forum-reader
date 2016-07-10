# Email to Jabber notifications.
#
module Mailer
  BOTE_NAME = 'mailer'.freeze

  BOTE_JID = BOTE_NAME + '@' + APP::HOST

  if defined?(Rails)
    require_relative 'piper.rb'
  end
end
