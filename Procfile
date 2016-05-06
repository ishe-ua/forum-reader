web:      bundle exec puma
clock:    bundle exec clockwork lib/clock.rb

worker:   bundle exec backburner -q forum-reader.default
fetcher:  bundle exec ruby lib/reader/fetcher/run.rb
