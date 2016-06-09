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

    def find_letters_for_send
      # TODO
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
  end
end
