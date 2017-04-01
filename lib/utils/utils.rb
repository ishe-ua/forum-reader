# App Utilites.
module Utils
  Dir[File.expand_path('**/*.rb', __dir__)].each do |file|
    require(file) if file != __FILE__
  end
end
