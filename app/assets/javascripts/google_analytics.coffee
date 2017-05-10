##
# Google Analitics для turbolinks.
#
# See app/view/shared/_google_analitics.html.erb
#

$(document).on 'turbolinks:load', ->

  if window._gaq?
    _gaq.push ['_trackPageview']
  else if window.pageTracker?
    pageTracker._trackPageview()
