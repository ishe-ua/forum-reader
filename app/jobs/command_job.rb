# Base for Cmd jobs.
class CommandJob < ApplicationJob
  # From whom Cmd, see #find_user_from
  attr_reader :user

  # Default reply for some Cmd.
  DONE = 'DONE'.freeze

  protected

  def find_user_from(job)
    full_jid = args_from(job).second
    jid = stripped(full_jid)

    @user = User.find_by(jabber: jid)
    raise_if_user_not_found(full_jid)
  end

  # Remove resource from Jabber ID.
  def stripped(full_jid)
    Blather::JID.new(full_jid).strip
  end

  def raise_if_user_not_found(full_jid)
    raise "User not found #{full_jid}" if user.nil?
  end
end
