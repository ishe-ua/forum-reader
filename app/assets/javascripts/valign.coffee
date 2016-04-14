##
# Выравнивание в формах (label и input-полей):
#
# Находим все эл-ты с классом '.valign' и выравниваем их по горизонтали.
# Файл от верстальщика.
#
$.fn.v_align = ->
  return this.each (i) ->

    ah = $(this).height()
    ph = $(this).parents('.field').first().height()
    mh = Math.ceil((ph-ah) / 2)
    $(this).css('margin-top', mh)

$(document).on 'page:change', ->
  $('.valign').v_align()
