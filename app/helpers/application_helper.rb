# coding: utf-8
# See ApplicationController.
module ApplicationHelper
  # Title tag for browser.
  def app_title
    APP::NAME
  end

  # Examples:
  #
  # * "2015"
  # * "2015-2016"
  #
  def app_years
    year1 = APP::SINCE
    year2 = Time.zone.now.year
    year1 == year2 ? year1.to_s : "#{year1}-#{year2}"
  end

  # Copyright string for footer.
  def copyright
    app_link = link_to APP::NAME.upcase, root_url
    "&copy; «#{app_link}» #{app_years}. #{t('footer.copyright')}."
  end

  # String or '-' if string is empty.
  def dashed(str)
    str.present? ? str : '-'
  end
end
