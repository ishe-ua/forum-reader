module Reader
  module Cmd
    # +Last+ command from BoteIn
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /last/

      include Cmd # TODO

      # Like ListJob
      def perform(body, from)
        user = find_user_from(from)
        params = find_params_from(body)

        reply_to(from) if user && valid?(params)
      end

      protected

      def find_params_from(body)
        tokens = body.split
        params_from(tokens[1], tokens[2])
      end

      def reply_to(from)
        obj = find_obj_by(user, params[:name])
        body = obj ? build_selection(obj) : CommandJob::NOT_FOUND
        ReplyJob.perform_later(body, from)
      end

      private

      # rubocop:disable LineLength

      def build_selection(obj)
        model_name = ActiveModel::Naming.singular(obj)
        feed_items = instance_eval("from_#{model_name}(obj)").order(:created_at).last(params[:count])

        if feed_items.any?
          ReplyMailer.selection(user, feed_items, params[:plus])
                     .body
                     .encoded.strip
        else
          CommandJob::EMPTY
        end
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
