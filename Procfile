web:    bundle exec puma
clock:  bundle exec clockwork lib/clock.rb
worker: bundle exec backburner -q forum-reader.default

reader_fetcher: bin/run reader/fetcher
reader_bot_in:  bin/run reader/bote_in
reader_bot_out: bin/run reader/bote_out
