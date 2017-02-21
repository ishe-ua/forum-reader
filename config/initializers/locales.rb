# coding: utf-8
# Настройка локалей, gem 'rails-i18n'
#

Rails.application
     .config
     .i18n.load_path +=
  Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

Rails.application
     .config
     .i18n.default_locale = :en

## Загружаем только эти локали (gem 'rails-i18n')
Rails.application
     .config
     .i18n.available_locales = APP::LANGS.map(&:to_sym)

## Raises error for missing translations
if Rails.env.development? || Rails.env.test?
  Rails.application
       .config
       .action_view.raise_on_missing_translations = true
end

## Выставляем произвольную локаль (чтобы тестировалось для разных)
if Rails.env.test?
  Rails.application
       .config
       .i18n.default_locale = APP::LANGS.shuffle.sample.to_sym
end
