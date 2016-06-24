module Reader
  # Send Forum news.
  class SendForumsJob < ActiveJob::Base
    queue_as :default

    # Param:
    # * +url+ Url of Forum
    def perform(url)
      feed = Feed.find_or_create_by(url: url)
      return unless feed

      Forum.where(url: url).find_each do |forum|
        news = find_unsended_news_in(forum)
        send(forum, news)
        update_last_post_at(forum)
      end
    end

    protected

    def find_unsended_news_in(forum)
      since = forum.last_post_at || Time.zone.now
      feed.feed_items.where('created_at > ?', since).order(:created_at)
    end

    # Send ReplyMailer#forum_news to Target
    def send(forum, news)
      news.each do |feed_item|
        mail = ReplyMailer.forum_news(forum, feed_item)
        mail.deliver_later if forum.email?
        ReplyJob.perform(mail.text_body, forum.jabber) if forum.jabber?
      end
    end

    def update_last_post_at(forum)
      current_time = Time.zone.now
      forum.update!(last_post_at: current_time)
    end
  end
end
