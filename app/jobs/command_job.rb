# Base for Cmd jobs.
class CommandJob < ApplicationJob
  # From whom Cmd?
  attr_accessor :user

  # Which params with Cmd?
  attr_accessor :params

  DONE = 'DONE'.freeze

  EMPTY = 'EMPTY'.freeze

  NOT_FOUND = '??'.freeze

  DEFAULT_SELECTION_SIZE = 5

  MAX_SELECTION_SIZE = 200

  protected

  # Also remove resource from full_jid
  def find_user_from(full_jid)
    jid = Blather::JID.new(full_jid).strip
    User.find_by(jabber: jid)
  end

  # See Reader::Cmd::LastJob#find_params_from and
  # Reader::Cmd::ListJob#find_params_from
  def params_from(token1, token2)
    {
      name: find_name_from(token1),
      plus: with_plus?(token1),
      count: find_count_from(token2)
    }
  end

  # See #params_from and #params
  def valid?(params)
    params && params[:name].present?
  end

  private

  def find_name_from(token)
    t = (token || '').strip
    with_plus?(t) ? t.chop : t
  end

  def find_count_from(token)
    count = token.to_i.abs
    count = DEFAULT_SELECTION_SIZE if count <= 0
    count = MAX_SELECTION_SIZE if count > MAX_SELECTION_SIZE
    count
  end

  def with_plus?(token)
    (token || '').strip.last == '+'
  end
end
