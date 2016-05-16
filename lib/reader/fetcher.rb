require_relative '../../config/initializers/active_job'
require_relative '../helpers.rb'

require 'eventmachine'
require 'em-http'
require 'rchardet'

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
    CONNECTION_OPTS = { connect_timeout: 15, inactivity_timeout: 30 }.freeze

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

      ## Make request to Url and enqueue FetchedFeedJob.
      def process(job)
        url = Helpers.args_from(job).first # TODO: test
        resource_type = Helpers.args_from(job).second # TODO: test

        conn_opts = CONNECTION_OPTS.dup
        request_opts = REQUEST_OPTS.dup

        http = EM::HttpRequest.new(url, conn_opts).get(request_opts)
        http.callback { enqueue_ffj(url, http.response, resource_type) }
      end

      # Find Feed encoding and encode to utf-8.
      #
      # gem 'rchardet'

      def encode(response)
        if response.encoding == Encoding::ASCII_8BIT
          feed_encoding = CharDet.detect(response)['encoding']
          response.force_encoding(feed_encoding)
        end

        response.encode(Encoding::UTF_8)
      end

      private

      def enqueue_ffj(url, response, resource_type)
        FetchedFeedJob.perform_later(url,
                                     encode(response),
                                     resource_type) unless
          response.blank?
      end
    end
  end
end

## Run in console (see Procfile)
Reader::Fetcher.run unless defined?(Rails)
