unless Rails.env.development? && Rails.env.test?
  Rails.application
       .config
       .lograge.enabled = true
end
