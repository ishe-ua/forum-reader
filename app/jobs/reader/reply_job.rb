module Reader
  # Send message to Jabber.
  #
  # Incoming job for BoteOut.
  class ReplyJob < ApplicationJob
    queue_as :default

    # Compose hash for BoteOut and put to Redis.
    #
    # Params:
    # - +text+ What send
    # - +to+ Whom send (jid with resource)

    def perform(text, to)
      hash = { text: text.strip, to: to.strip }
      redis.lpush(BoteOut::REDIS_KEY, hash.to_json)
    end
  end
end
