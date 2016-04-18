##
# Выравнивание в формах (label и input-полей):
#
# Находим все label в формах и выравниваем их по вертикали.
# Файл от верстальщика.
#
$.fn.v_align = ->
  return this.each (i) ->

    ah = $(this).height()
    ph = $(this).parents('.field').first().height()
    mh = Math.ceil((ph-ah) / 2)
    $(this).css('margin-top', mh)

$(document).on 'page:change', ->
  $('form label').v_align()
