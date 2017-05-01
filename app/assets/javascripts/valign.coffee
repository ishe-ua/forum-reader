##
# Выравнивание полей (файл верстальщика).
#
# Находим все label (и не только) в формах и выравниваем их по
# вертикали.
#
# $.fn.v_align = ->
#   return this.each (i) ->

#     ah = $(this).height()
#     ph = $(this).parents('.field').first().height()
#     mh = Math.ceil((ph-ah) / 2)
#     $(this).css('margin-top', mh)

# $(document).on 'page:change', ->
#   $('form label, .info-name').v_align()
