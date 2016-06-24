module Reader
  # Send Forum updates to User -s
  class SendForumsJob < ActiveJob::Base
    queue_as :default

    # Param:
    # * +url+ Url of Forum
    def perform(url)
      feed = Feed.find_or_create_by(url: url)
      return unless feed

      Forum.where(url: url).find_each { |forum| send(news_in(forum)) }
    end

    protected

    def news_in(forum)
      time = forum.last_post_at || Time.zone.now
      feed.feed_items.where('created_at > ?', time).order(:created_at)
    end

    # Send ReplyMailer#forum_news to Target
    def send(feed_items)
      feed_items.each do |feed_item|
        mail = ReplyMailer.forum_news(forum, feed_item)
        mail.deliver_later if forum.email?
        ReplyJob.perform(mail.text_body, forum.jabber) if forum.jabber?
      end
    end
  end
end
