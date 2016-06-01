module Reader
  # Send message to Jabber.
  #
  # Incoming job for BoteOut.
  #
  class ReplyJob < ActiveJob::Base
    queue_as { Reader::BoteOut::QUEUE_NAME }

    # +Deprecated+ method (should performs in Cmd -jobs).
    #
    # Params:
    # - +text+ What send
    # - +to+ Whom send (jid with resource)

    def perform(_text, _to)
      raise 'Deprecated'
    end
  end
end
