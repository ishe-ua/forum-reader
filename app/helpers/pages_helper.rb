# See PagesController.
#
module PagesHelper
  ## Link to wiki page with locale.
  def xmpp_wiki_path
    "http://#{I18n.locale}.wikipedia.org/wiki/XMPP"
  end

  ## Country / Lang / Timezone.
  def country_tz_lang(user)
    country = Country::COUNTRIES_HASH[user.country]
    "#{dashed country} / #{dashed user.timezone} / #{dashed user.lang}"
  end

  ## Delivery days.
  def post_days(letter) # rubocop:disable all
    @day_abbrs ||=
      [''].push(Letter.human_attribute_name('d1'))
          .push(Letter.human_attribute_name('d2'))
          .push(Letter.human_attribute_name('d3'))
          .push(Letter.human_attribute_name('d4'))
          .push(Letter.human_attribute_name('d5'))
          .push(Letter.human_attribute_name('d6'))
          .push(Letter.human_attribute_name('d7'))

    days = []

    (days << @day_abbrs[1]) if letter.d1
    (days << @day_abbrs[2]) if letter.d2
    (days << @day_abbrs[3]) if letter.d3
    (days << @day_abbrs[4]) if letter.d4
    (days << @day_abbrs[5]) if letter.d5
    (days << @day_abbrs[6]) if letter.d6
    (days << @day_abbrs[7]) if letter.d7

    days
  end

  ## Delivery times (with User 's Timezone).
  def post_time(letter)
    h = letter.hour
    m = letter.minute

    m = if m < 10
          "0#{m}"
        else
          m
        end

    "#{h}:#{m}"
  end

  ## Paths from route.rb for icons.
  def icon_path(resource, action)
    model = resource.class.name.underscore
    route = "#{action}_#{model}_path(resource)"

    instance_eval(route)
  end
end
