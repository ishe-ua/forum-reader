module Reader
  # Send Letter -s by Schedule.
  #
  # Clockwork task
  class SendLettersJob < ApplicationJob
    queue_as :default

    attr_reader :time
    include Cmd

    def perform(enqueue_job_time)
      @time = enqueue_job_time

      find_letters_for_send.each do |letter|
        news = news_in(letter)
        CmdMailer.letter_with_news(letter, news).deliver_later if news.any?
      end
    end

    protected

    # <tt>IMPORTANT:</tt> hard request
    def find_letters_for_send
      list = []

      Letter.where('minute == ?', time.min).find_each do |letter|
        list.push(letter) if send_time?(letter)
      end

      list
    end

    def news_in(letter)
      letter.letter_items.order(:position).select do |letter_item|
        news = news_in_the(letter_item)
        { letter_item => news } if news.any?
      end
    end

    def news_in_the(letter_item)
      feed = Feed.find_or_create_by(url: letter_item.url)

      time1 = letter_item.last_post_at || time
      time2 = time

      find_news_in(feed, time1, time2)
    end

    private

    def send_time?(letter)
      t = time.in_time_zone(letter.user.timezone)
      t.hour == letter.hour && instance_eval("letter.d#{t.wday}")
    end
  end
end
