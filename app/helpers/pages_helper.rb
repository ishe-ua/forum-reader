# coding: utf-8
# Хелперы для PagesController.
#
module PagesHelper
  ## Ссылка на wiki-страницу с учетом текущей локали.
  def xmpp_wiki_path
    "http://#{I18n.locale}.wikipedia.org/wiki/XMPP"
  end
end
