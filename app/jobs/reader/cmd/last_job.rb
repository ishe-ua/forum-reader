module Reader
  module Cmd
    # +Last+ command
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /^\s*LAST\s*\S{1,}\+?\s*\d*\s*$/i

      include Cmd

      # Like ListJob
      def perform(body, from)
        return unless body.match?(self.class::REGEXP) # !!
        return unless (user = find_user_from(from))

        params = find_params_from(body)
        text = if valid?(params) && (obj = find_obj_by(user, params[:name]))
                 gen_selection(user, params, obj)
               else
                 CommandJob::NOT_FOUND
               end

        ReplyJob.perform_later(text, from)
        text # for tests
      end

      protected

      # For LastJob and ListJob commands
      def find_params_from(body)
        tokens = body.split

        p = params_from(tokens[1], tokens[2]) if instance_of?(LastJob)
        p = params_from(tokens[0], tokens[1]) if instance_of?(ListJob)
        p
      end

      def gen_selection(user, params, obj)
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

        op = '<=' if instance_of?(LastJob)
        op = '>'  if instance_of?(ListJob)

        feed.feed_items.where("created_at #{op} ?", time)
      end

      alias from_forum from
      alias from_letter_item from

      def from_letter(obj)
        rel = nil
        obj.letter_items.each do |li|
          sel = from(li)
          rel ? rel.union(sel) : (rel = sel)
        end

        rel || FeedItem.none
      end
    end
  end
end
