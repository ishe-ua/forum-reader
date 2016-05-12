require_relative '../../config/initializers/active_job'
require_relative '../helpers.rb'

require 'eventmachine'
require 'em-http'

module Reader
  # Fetch Forum -s and Letter -s periodically from remote Url -s.
  #
  # Parts:
  #
  # 1. FetchForumsJob
  # 2. FetchLettersJob
  # 3. FetchFeedJob
  # 4. FetchedFeedJob
  #
  module Fetcher
    QUEUE_NAME = 'reader.fetcher'.to_sym

    # See https://github.com/igrigorik/em-http-request/wiki/Redirects-and-Timeouts
    REQUEST_PARAMS = { connect_timeout: 15, inactivity_timeout: 30 }.freeze

    # See https://github.com/igrigorik/em-http-request/wiki/Redirects-and-Timeouts
    #
    # http error 301 (pravda.com.ua/rss redirect to pravda.com.ua/rss/)
    REQUEST_OPTS = { redirects: 2 }.freeze

    class << self
      # Wait for FetchFeedJob -s and process them.
      #
      # See Procfile

      def run
        EM.run do
          trap(:INT)  { EM.stop }
          trap(:TERM) { EM.stop }

          tube = Helpers.get_tube(QUEUE_NAME)
          while tube.peek(:ready)
            job = tube.reserve
            process(job)
            job.delete
          end
        end
      end

      # Only +forum+ or +letter_item+.
      def raise_if_bad(resource_type)
        raise 'Bad resource_type' if resource_type != Forum.to_s &&
                                     resource_type != LetterItem.to_s
      end

      protected

      # Make request to Url and enqueue FetchedFeedJob with response
      # body.

      def process(job)
        url = Helpers.args_from(job).first # TODO: test
        resource_type = Helpers.args_from(job).second # TODO: test

        http = EM::HttpRequest.new(url, REQUEST_PARAMS.dup).get REQUEST_OPTS.dup
        http.callback { enqueue_ffj(url, http.response, resource_type) }
      end

      private

      def enqueue_ffj(url, response, resource_type)
        FetchedFeedJob.perform_later(url, response, resource_type) unless
          response.blank?
      end
    end
  end
end

## Run in console
Reader::Fetcher.run unless defined?(Rails)
