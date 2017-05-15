# rubocop:disable AbcSize
# rubocop:disable MethodLength

def build_watcher(name, cmd, opts = {})
  God.watch do |w|
    raise 'Opts error' unless opts[:group] || opts[:dir]

    w.group = opts[:group] if opts[:group]
    w.name  = "#{opts[:group]}-#{name}"
    w.start = cmd

    w.keepalive
    w.env = opts[:env] ? opts[:env] : { 'RAILS_ENV' => 'production' }

    w.dir     = "/home/deploy/#{opts[:dir]}/current"
    w.log     = "/home/deploy/#{opts[:dir]}/current/log/stdout-#{name}.log"
    w.err_log = "/home/deploy/#{opts[:dir]}/current/log/stderr-#{name}.log"
  end
end

###
#
#

opts = { group: 'forum-reader', dir: 'forum-reader2.com' }

build_watcher('web', 'bundle exec puma', opts)
build_watcher('clock', 'bundle exec clockwork lib/clock.rb', opts)
build_watcher('worker', 'bundle exec sidekiq', opts)

build_watcher('bote-in', 'bundle exec ruby lib/reader/bote_in.rb', opts)
build_watcher('bote-out', 'bundle exec ruby lib/reader/bote_out.rb', opts)
