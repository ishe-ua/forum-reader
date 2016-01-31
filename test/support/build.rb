##
# Build instance of model from fixture's DEFAULTS.
#

def build(model_name, attributes = {})
  hash = begin
           path = fixtures_path + '/' + model_name.to_s.pluralize + '.yml'
           line = YAML.load(ERB.new(File.read(path)).result)['DEFAULTS']

           erb = ERB.new(line.to_s.gsub '$LABEL', 'sample').result
           instance_eval(erb)
         end

  attributes.each do |key, value|
    hash[key] = value
  end

  ###
  #
  #

  if model_name == :account
    # hash[:password]              = APP::DEFAULT_PASSWORD
    # hash[:password_confirmation] = APP::DEFAULT_PASSWORD
  end

  ###
  #
  #

  correction = lambda do |ref|
    if hash[ref].present?
      hash["#{ref}_id"] = if ref == 'feed'
                            feeds(hash[ref].to_sym).id
                          elsif ref == 'letter'
                            letters(hash[ref].to_sym).id
                          else
                            users(hash[ref].to_sym).id
                          end
      hash.delete(ref)
    end
  end

  correction.call('account')
  correction.call('user')
  correction.call('forum')
  correction.call('letter')
  correction.call('letter_item')
  correction.call('feed')
  correction.call('feed_item')

  ###
  #
  #

  model_name.to_s
    .classify
    .constantize.new(hash)
end
