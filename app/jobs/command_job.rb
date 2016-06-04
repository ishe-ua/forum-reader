# Base for Cmd jobs.
class CommandJob < ApplicationJob
  # From whom Cmd?
  attr_accessor :user

  # Which params with Cmd?
  attr_accessor :params

  # Default reply for some Cmd.
  DONE = 'DONE'.freeze

  protected

  # Also remove resource from full_jid
  def find_user_from(full_jid)
    jid = Blather::JID.new(full_jid).strip
    User.find_by(jabber: jid)
  end

  # See #with_plus?
  def find_name_from(token)
    t = (token || '').strip
    with_plus?(t) ? t.chop : t
  end

  # See #with_plus?
  def find_count_from(token)
    count = token.to_i.abs
    count = Reader::DEFAULT_SELECTION_SIZE if count <= 0
    count = Reader::MAX_SELECTION_SIZE if count > Reader::MAX_SELECTION_SIZE
    count
  end

  # For commands like Reader::Cmd::LastJob and Reader::Cmd::ListJob
  def with_plus?(token)
    (token || '').strip
                 .last == '+'
  end
end
