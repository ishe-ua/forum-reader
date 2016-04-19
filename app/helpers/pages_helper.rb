# coding: utf-8
# Хелперы для PagesController.
#
module PagesHelper
  ## Ссылка на wiki-страницу с учетом текущей локали.
  def xmpp_wiki_path
    "http://#{I18n.locale}.wikipedia.org/wiki/XMPP"
  end

  ## Страна / Локаль / Временная_зона.
  def country_tz_lang(user)
    country = Country::COUNTRIES_HASH[user.lang.to_s]
    "#{dashed country} / #{dashed user.timezone} / #{dashed user.lang}"
  end
end
