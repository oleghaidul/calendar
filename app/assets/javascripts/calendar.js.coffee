class Currency
  constructor:(element) ->
    @el = element
    text = @el.find('option:selected').text()
    @el.parent().prepend("<span class='add-on'>#{@cut_text(text)}</span>")
    @addon = $('span.add-on')

  save_list: ->
    @list = @el.text()

  render: ->
    @render_addon()
    @el.hide()

  render_addon: ->
    text = @el.find('option:selected').text()
    console.log(@addon)
    @addon.text(@cut_text(text))

  cut_text: (text) ->
    first_index = text.indexOf("(")
    last_index = text.indexOf(")")
    length= last_index - first_index
    text.substr(first_index+1, length-1)
$ ->

  $('.test').hover ->
    $(@).tooltip()

  $.fn.extend
    currency_edit: ->
      currency = new Currency($(@))
      currency.save_list()
      currency.el.hide()
      $('span.add-on').click ->
        # currency.el.show()
        currency.el.show()
      @change ->
        text = $("#price_period_currency_id option:selected").text()
        currency.render()

  $.fn.extend
    show_popover: ->
      @click ->
        calendar_id = $(@).closest('.ability').data('calendar-id')
        $('.popover').remove()
        if !$(@).hasClass('hover')
          is_hover = true
        else
          is_hover = false
        data = $(this).data("date")
        $('.day').popover(
          html: true
          placement: get_popover_placement
          title: "title"
          trigger: "manual"
        )
        $(this).popover "show"
        position = $(this).position()
        calendar_height = $('.calendar-wrapper').css("height")
        calendar_height = parseInt(calendar_height)
        pop_top = $('.popover').position().top
        crit_top = calendar_height - 100
        $('.popover').css("top", position.top - 150)
        pop_pos = $('.popover').position()
        temp = position.top - pop_pos.top
        proc = temp * 100 / 522
        y_coord = proc / 100 * 522 + 8
        $('.arrow').css("top", y_coord)
        $(".popover").hide()
        if is_hover
          $.ajax(
            url: "/periods/new?calendar_id=#{calendar_id}"
            cache: false
            ).done ->
              $("#period-form").validate()
              $(".popover").show()
              $('#period_start_date').val(data)
              $('[class~=datepicker]').datepicker
                "autoclose": true
                format: 'dd-mm-yyyy'
                startDate: data
                $('input.cp1').colorpicker()
                theme: "red"
                mode: "click"
                showSpeed: 200
                hideSpeed: 200
                onSelect: (color) ->
                  $('#period_color').val(color)
              $('.close_form').click ->
                $('.colorpicker.dropdown-menu').remove()
                $('.popover').remove()
              $('#show_more').click ->
                if $('.show_more_fields').css("display") == "none"
                  $('.show_more_fields').show('slow')
                  $('#show_more').html("show less")
                else
                  $('.show_more_fields').hide('slow')
                  $('#show_more').html("show more")
        else
          calendar_id = $(@).closest('.ability').data('calendar-id')
          period_id = $(@).data('period-id')
          $.ajax(
            url: "/periods/#{period_id}/edit?calendar_id=#{calendar_id}"
            cache: false
            ).done ->
              $("#period-form").validate()
              $(".popover").show()
              $('[class~=datepicker]').datepicker
                "autoclose": true
                format: 'dd-mm-yyyy'
                startDate: data
                $('input.cp1').colorpicker()
                theme: "red"
                mode: "click"
                showSpeed: 200
                hideSpeed: 200
                onSelect: (color) ->
                  $('#period_color').val(color)
              $('.close_form').click ->
                $('.colorpicker.dropdown-menu').remove()
                $('.popover').remove()
              $('#show_more').click ->
                if $('.show_more_fields').css("display") == "none"
                  $('.show_more_fields').show('slow')
                  $('#show_more').html("show less")
                else
                  $('.show_more_fields').hide('slow')
                  $('#show_more').html("show more")

  if $('.ability').data('editable')
    $('.day').show_popover()

  get_popover_placement = (pop, dom_el) ->
    width = window.innerWidth
    width = width / 2
    left_pos = $(dom_el).offset().left
    return "left"  if width < left_pos
    "right"

  $.fn.extend
    colorize: ->
      @hover ->
        if $(@).data('period-id')
          period_id = $(@).data('period-id')[0] || $(@).data('period-id')
        $(".day[data-period-id^='[#{period_id}']").toggleClass('hover')
        $(".day[data-period-id=#{period_id}][data-status=start]").toggleClass('hover all')
        $(".day[data-period-id=#{period_id}][data-status=between]").toggleClass('hover all')

  $('.day').colorize()

  $('.day').mouseenter ->
    if $(@).data("per-night")
      span_pos = $(@).position()
      price_text = "Per night " + $(@).data("per-night")
      country = $(@).data("currency")
      first_index = country.indexOf("(")
      last_index = country.indexOf(")")
      length= last_index - first_index
      country = country.substr(first_index+1, length-1)
      price_text += " " + country
      $('.price_period').text(price_text).show().css("top", span_pos.top - 20).css("left", span_pos.left - 50)

  $('.day').mouseleave ->
    $('.price_period').hide()

  default_color = $('#calendar_color_color_hash').val() || '#ff0000'

  $('.calendar-color').wColorPicker
    initColor: $('.header').css('backgroundColor')
    theme: "red"
    mode: "click"
    showSpeed: 200
    hideSpeed: 200
    onSelect: (color) ->
      $('#calendar_color').val(color)

  $('.calendar_color').wColorPicker
    initColor: default_color
    theme: "red"
    mode: "click"
    showSpeed: 200
    hideSpeed: 200
    onSelect: (color) ->
      $('#calendar_color_color_hash').val(color)

  $.cssHooks.backgroundColor = get: (elem) ->
  if elem.currentStyle
    bg = elem.currentStyle["backgroundColor"]
  else bg = document.defaultView.getComputedStyle(elem, null).getPropertyValue("background-color")  if window.getComputedStyle
  unless bg.search("rgb") is -1
    hex = (x) ->
      ("0" + parseInt(x).toString(16)).slice -2
    bg = bg.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/)
    "#" + hex(bg[1]) + hex(bg[2]) + hex(bg[3])
