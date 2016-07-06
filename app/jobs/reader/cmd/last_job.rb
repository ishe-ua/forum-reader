module Reader
  module Cmd
    # +Last+ command
    class LastJob < CommandJob
      queue_as :default

      REGEXP = /^\s*LAST\s*\S{1,}\+?\s*\d*\s*$/i

      include Cmd

      # Like ListJob
      def perform(body, from) # rubocop:disable MethodLength
        return unless body =~ REGEXP
        if (user = find_user_from(from))
          params = find_params_from(body)
          text = if valid?(params)
                   gen_selection(user, params)
                 else
                   CommandJob::NOT_FOUND
                 end

          ReplyJob.perform_later(text, from)
          text # for tests
        end
      end

      protected

      # For LastJob and ListJob commands
      def find_params_from(body, cmd = :last)
        tokens = body.split

        p = params_from(tokens[1], tokens[2]) if cmd == :last
        p = params_from(tokens[0], tokens[1]) if cmd == :list
        p
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

      def from(obj, cmd = :last)
        time = obj.last_post_at || Time.zone.now
        feed = Feed.find_or_create_by(url: obj.url)

        op = '<=' if cmd == :last
        op = '>'  if cmd == :list

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

        rel
      end
    end
  end
end
