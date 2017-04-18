module Reader
  # Income input from BoteIn and run Cmd.
  class InJob < ApplicationJob
    queue_as :default

    def perform(body, from)
      SUPPORTED_COMMANDS.each do |cmd|
        klass = "Reader::Cmd::#{cmd.capitalize}Job".classify.constantize
        if body.match?(klass::REGEXP)
          klass.perform_later(body, from)
          return cmd
        end
      end
    end
  end
end
