# See bin/pipe and Mailer::Piper
#
# Postfix run bin/pipe which needs gems in
# config/ansible/roles/postfix/vars/main.yml#gem_home. TODO: check
#
# HACK!!

# if Rails.env.production?
#   gem_home =
#     "/home/deployer/#{APP::HOST}/shared/bundle/ruby/#{RUBY_VERSION}/gems"
#   gem_home_dirs = Dir.entries(gem_home)

#   Mailer::Piper::REQUIRED_LIBS.each do |lib|
#     b = false

#     gem_home_dirs.each do |dirname|
#       b = dirname.start_with?(lib.remove('_') + '-') unless b
#     end

#     raise "gem #{lib} not installed" unless b
#   end
# end

# TODO: unncomment
