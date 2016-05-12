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
  class Fetcher
    QUEUE_NAME = 'reader.fetcher'.to_sym

    # Wait for FetchFeedJob -s and process them.
    #
    # See Procfile

    def run
      EventMachine.run do
        tube = Helpers.get_tube(QUEUE_NAME)
        while tube.peek(:ready)
          job = tube.reserve
          process(job)
          job.delete
        end
      end
    end

    # Only +forum+ or +letter_item+.
    def self.raise_if_bad(resource_type)
      raise 'Bad resource_type' if resource_type != Forum.to_s &&
                                   resource_type != LetterItem.to_s
    end

    protected

    # Make request to Url and enqueue FetchedFeedJob with response
    # body.

    def process(job)
      url = Helpers.args_from(job).first # TODO: test
      resource_type = Helpers.args_from(job).second # TODO: test

      http = EventMachine::HttpRequest.new(url).get
      http.callback { enqueue_ffj(url, http.response, resource_type) }
    end

    private

    def enqueue_ffj(url, response, resource_type)
      FetchedFeedJob.perform_later(url, response, resource_type) unless
        response.blank?
    end
  end
end

## Run in console
Reader::Fetcher.new.run unless defined?(Rails)
