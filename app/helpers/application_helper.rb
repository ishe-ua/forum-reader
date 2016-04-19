# coding: utf-8
# Общие хелперы приложения.
#
module ApplicationHelper
  ## Title браузера.
  def app_title
    APP::NAME
  end

  ##
  # Годы жизни приложения. Два случая:
  #
  # * "2015" 1-й год жизни
  # * "2015-2016" не 1-й
  #

  def app_years
    year1 = APP::YEAR.to_i
    year2 = Time.zone.now.year
    year1 == year2 ? year1.to_s : "#{year1}-#{year2}"
  end

  ## Copyright-строка для footer-а.
  def copyright
    app_link = link_to APP::NAME.upcase, root_url
    "&copy; «#{app_link}» #{app_years}. #{t('footer.copyright')}."
  end

  ## Показываем строку или '-' если та пустая.
  def dashed(str)
    str.present? ? str : '-'
  end
end
