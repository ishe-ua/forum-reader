# Bote commons.
module Bote
  # From BOTE_JID constant or secrets.yml
  def bote_jid
    raise 'Undefined constant' unless defined?(BOTE_JID)
    if defined?(Rails)
      Rails.application.secrets.reader['bote']['jid']
    else
      BOTE_JID
    end
  end

  # From secrets.yml or ENV
  def bote_password
    if defined?(Rails)
      Rails.application.secrets.reader['bote']['password']
    else
      ENV['READER_BOTE_PASSWORD'] # TODO: read from secrets.yml
    end
  end
end
