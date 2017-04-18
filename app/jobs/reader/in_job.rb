module Reader
  # Income input from BoteIn and run Cmd.
  class InJob < ApplicationJob
    queue_as :default

    def perform(text, from)
      SUPPORTED_COMMANDS.each do |cmd|
        job = "Reader::Cmd::#{cmd.capitalize}Job".classify.constantize
        if text.match?(job::REGEXP)
          job.perform_later(text, from)
          return cmd
        end
      end
    end
  end
end
