module Mailer
  # Clean Message -s (like Reader::CleanerJob)
  #
  # Clockwork task
  class CleanerJob < ActiveJob::Base
    queue_as :default

    MIN_STORE_TIME = Reader::CleanerJob::MIN_STORE_TIME

    MIN_STORE_ITEMS = Reader::CleanerJob::MIN_STORE_ITEMS

    def perform
      User.find_each do |user|
        find_messages_for_clean(user).delete_all
      end
    end

    protected

    def find_messages_for_clean(user)
      rel = user.messages
      rel.where('created_at < ?', MIN_STORE_TIME.ago) if rel.count >
                                                         MIN_STORE_ITEMS
      rel
    end
  end
end
