module Reader
  module Cmd
    # +Last+ command from BoteIn
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /^\s*LAST\s*\S{1,}\+?\s*\d*\s*$/i

      include Cmd

      # Like ListJob
      def perform(body, from)
        return unless body =~ REGEXP
        if (user = find_user_from(from))
          params = find_params_from(body)
          text = if valid?(params)
                   gen_selection(user, params)
                 else
                   CommandJob::NOT_FOUND
                 end

          ReplyJob.perform_later(text, from)
        end
      end

      protected

      def find_params_from(body)
        tokens = body.split
        params_from(tokens[1], tokens[2])
      end

      def gen_selection(user, params)
        obj = find_obj_by(user, params[:name])
        return CommandJob::NOT_FOUND unless obj

        feed_items = find_feed_items(obj, params[:count])

        if feed_items.any?
          ReplyMailer.selection(user, feed_items, params[:plus])
                     .body
                     .encoded
        else
          CommandJob::EMPTY
        end
      end

      private

      def find_feed_items(obj, count)
        model_name = ActiveModel::Naming.singular(obj)
        instance_eval("from_#{model_name}(obj)").order(:created_at).last(count)
      end

      def from(obj)
        time = obj.last_post_at || Time.zone.now
        feed = Feed.find_or_create_by(url: obj.url)

        feed.feed_items.where('created_at <= ?', time)
      end

      alias from_forum from
      alias from_letter_item from

      def from_letter(obj)
        rel = FeedItem.none
        obj.letter_items.each { |li| rel.merge(from(li)) }
        rel
      end
    end
  end
end
