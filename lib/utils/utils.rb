# App Utilites.
module Utils
  Dir[Rails.root.join('lib', 'utils', '**', '*.rb')].each do |file|
    require(file) if file != __FILE__ # except current file
  end
end
