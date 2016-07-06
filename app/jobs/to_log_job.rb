# Write message to Rails log.
#
# +Proxy+ for runs <tt>without Rails env</tt> (like Reader::Fetcher).
class ToLogJob < ActiveJob::Base
  queue_as :default

  # Example: ToLogJob.perform_letter('Bad url', :info)
  #
  def perform(msg, level)
    raise 'Unsupported level type' unless level.instance_of?(String)
    raise 'Empty msg' if msg.blank?

    Rails.logger.send(level, msg)
  end
end
