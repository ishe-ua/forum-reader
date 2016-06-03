# Base for Cmd jobs.
class CommandJob < ApplicationJob
  # Default reply for some Cmd.
  DONE = 'DONE'.freeze

  protected

  # Remove resource from incoming Jabber and find User.
  #
  # Example: from = 'user@example.com/ipad'

  def find_user(from)
    jid_without_resource = Blather::JID.new(from).strip
    User.find_by(jabber: jid_without_resource)
  end
end
