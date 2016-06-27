require_relative '../../config/initializers/active_job'

require 'eventmachine'
require 'em-http'
require 'rchardet'

module Reader
  # Fetch Forum -s and Letter -s periodically from remote Url -s.
  #
  module Fetcher
    QUEUE_NAME = 'reader.fetcher'.to_sym

    extend Utils::Queues

    # See https://github.com/igrigorik/em-http-request/wiki/Redirects-and-Timeouts
    CONNECT_OPTS = { connect_timeout: 15, inactivity_timeout: 30 }.freeze

    # See https://github.com/igrigorik/em-http-request/wiki/Redirects-and-Timeouts
    #
    # http error 301 (pravda.com.ua/rss redirect to pravda.com.ua/rss/)
    REQUEST_PARAMS = { redirects: 2 }.freeze

    class << self
      # Wait for FetchFeedJob -s in QUEUE_NAME and process them.
      #
      # See Procfile

      def run
        EM.run do
          EM.add_periodic_timer(1) do
            jobs_from(QUEUE_NAME) { |job| process_incoming(job) }
          end
        end
      end

      protected

      # Do +em+-request to Url and enqueue FetchedFeedJob with
      # response.
      def process_incoming(job)
        url = args_from(job).first

        conn_opts = CONNECT_OPTS.dup
        request_params = REQUEST_PARAMS.dup

        http = EM::HttpRequest.new(url, conn_opts).get(request_params)
        http.callback { enqueue_ffj(url, http.response) }
      end

      # Find Feed encoding and encode to <tt>utf-8</tt>.
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

      def enqueue_ffj(url, response)
        FetchedFeedJob.perform_later(url, encode(response)) unless
          response.blank?
      end
    end
  end
end

## Run in console (see Procfile)
Reader::Fetcher.run unless defined?(Rails)
