# Base for Cmd jobs.
class CommandJob < ApplicationJob
  # Default reply for some Cmd.
  DONE = 'DONE'.freeze

  protected

  # Remove resource from Jabber ID.
  def stripped(jid)
    Blather::JID.new(jid).strip
  end

  # Remove resource from incoming Jabber and find User for it.
  #
  # Params:
  #
  # - +full_jid+ Jabber with resource like 'user@example.com/ipad'

  def find_user(full_jid)
    User.find_by(jabber: stripped(full_jid))
  end
end
