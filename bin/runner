#!/usr/bin/env ruby
# Run app part (see Procfile)

require 'active_support/core_ext/string'

file = "./lib/#{ARGV[0]}.rb"
klass = ARGV[0].classify
method = klass + '.run'

system "bundle exec ruby -r #{file} -e #{method}"
