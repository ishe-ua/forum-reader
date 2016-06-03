module Reader
  # Send message to Jabber.
  #
  # Incoming job for BoteOut.
  #
  class ReplyJob < ApplicationJob
    queue_as { Reader::BoteOut::QUEUE_NAME }

    # +Deprecated+ method (should performs in Cmd -jobs).
    #
    # Params:
    # - +body+ What send
    # - +to+ Whom send (jid with resource)

    def perform(_body, _to)
      raise 'Deprecated'
    end
  end
end
