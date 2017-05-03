module Reader
  # Send Forum news.
  class SendForumsJob < ActiveJob::Base
    queue_as :default

    # Param:
    # * +url_or_user_id+ Url of Forum or id of the User
    def perform(url_or_user_id)
      user = User.find(url_or_user_id) if url_or_user_id.is_a?(Integer)
      sel = user ? user.forums : Forum.where(url: url_or_user_id)

      news_count = 0
      sel.find_each { |forum| news_count += send_out(forum) }

      news_count.positive? ? news_count : nil
    end

    protected

    def send_out(forum)
      news = find_unsended_news_in(forum)
      return 0 if forum.user.reader_set.off? || news.empty?

      send_to_target(forum, news)
      update_last_post_at(forum)

      news.count
    end

    def find_unsended_news_in(forum)
      feed = Feed.find_by(url: forum.url)
      return [] unless feed

      since = forum.last_post_at || Time.zone.now
      feed.feed_items.where('created_at > ?', since).order(:created_at)
    end

    # Send ReplyMailer#forum_news to Target
    def send_to_target(forum, news)
      news.each do |feed_item|
        mail = ReplyMailer.forum_news(forum, feed_item)

        if forum.jabber?
          text = mail.text_part.body.decoded
          to = forum.user.jabber
          ReplyJob.perform_later(text, to)
        else
          mail.deliver_later
        end
      end
    end

    def update_last_post_at(forum)
      current_time = Time.zone.now
      forum.update!(last_post_at: current_time)
    end
  end
end
