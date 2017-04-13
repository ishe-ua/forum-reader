require 'xmpp4r'
require 'xmpp4r/roster'

module Utils
  # Xmpp4r helpers.
  module Xmpp
    include Jabber

    attr_reader :client
    attr_reader :jid
    attr_reader :roster

    # In seconds
    RECONNECT_TIMEOUT = 5

    def start(jabber_id, _opts = {})
      @jid = JID.new(jabber_id)
      @client = Client.new(jid)
      @roster = Roster::Helper.new(client)

      client.connect
      client.auth(APP::BOTES_PASSWORD)

      send_presence
    end

    def wait_msg
      _ = Thread.current

      client.add_message_callback do |msg|
        yield(msg.body, msg.from) if msg.body &&
                                     msg.from &&
                                     msg.type != :error
      end

      Thread.stop
      client.close
    end

    def send_msg(body, to)
      msg = Message.new(to, body.strip)
      msg.set_type(:chat)

      client.send(msg)
      send_presence # TODO: is this need here??
    end

    protected

    def send_presence
      stanza = Presence.new.set_type(:available)
      client.send(stanza)
    end

    def on_exception_callback
      client.on_exception do
        unless client&.is_connected?
          sleep(RECONNECT_TIMEOUT)
          start(jid, opts)
        end
      end
    end

    def on_subscription_request_callback
      roster.add_subscription_request_callback do |_, presence|
        from = presence.from
        roster.accept_subscription(from)
      end
    end
  end
end
