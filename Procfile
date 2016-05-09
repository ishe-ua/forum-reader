web:    bundle exec puma
clock:  bundle exec clockwork lib/clock.rb
worker: bundle exec backburner -q forum-reader.default

reader_fetcher: bundle exec bin/runner --app "Reader::Fetcher.run"
reader_bot_in:  bundle exec bin/runner --app "Reader::BotIn.run"
reader_bot_out: bundle exec bin/runner --app "Reader::BotOut.run"
