module Reader
  # Send Letter -s by Schedule.
  #
  # Clockwork task
  class SendLettersJob < ApplicationJob
    queue_as :default

    attr_reader :time
    include Cmd

    # Param should be String
    def perform(enqueue_job_time)
      @time = Time.zone.at(enqueue_job_time)
      find_letters_for_send.each do |letter|
        news = news_in(letter)
        if news&.any?
          ReplyMailer.letter_with_news(letter, news).deliver_later
          update_last_post_at(letter)
        end
      end
    end

    protected

    # <tt>WARN:</tt> heavy sql
    def find_letters_for_send
      list = []

      Letter.where(minute: time.min).find_each do |letter|
        list.push(letter) if send_time?(letter)
      end

      list
    end

    def news_in(letter)
      letter.letter_items.order(:position).select do |letter_item|
        news = news_in_the(letter_item)
        # { letter_item => news } if news.any?
        { letter_item: letter_item, feed_items: news } if news&.any?
      end
    end

    # Correct #time to now time
    def news_in_the(letter_item)
      feed = Feed.find_or_create_by(url: letter_item.url)

      time1 = letter_item.last_post_at || (time - 1.month)
      time2 = [time, Time.zone.now].max

      find_news_in(feed, time1, time2)
    end

    # Update LastPostAt for Letter and his LetterItem -s
    def update_last_post_at(letter)
      letter.update(last_post_at: time)
      letter.letter_items.each { |li| li.update(last_post_at: time) }
    end

    private

    def send_time?(letter)
      t = time.in_time_zone(letter.user.timezone)
      t.hour == letter.hour && instance_eval("letter.d#{t.wday}")
    end
  end
end
