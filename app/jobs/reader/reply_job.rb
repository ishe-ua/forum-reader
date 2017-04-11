module Reader
  # Send message to Jabber.
  #
  # Incoming job for BoteOut.
  class ReplyJob < ApplicationJob
    queue_as { BoteOut::QUEUE_NAME.to_sym }

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
