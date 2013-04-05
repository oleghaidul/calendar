$ ->

  if $('.ability').data('editable')
    $('.day').click ->
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
            $(".popover").show()
            $('#period_start_date').val(data)
            $('[class~=datepicker]').datepicker
              "autoclose": true
              format: 'yyyy-mm-dd'
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
            $(".popover").show()
            $('[class~=datepicker]').datepicker
              "autoclose": true
              format: 'yyyy-mm-dd'
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

  get_popover_placement = (pop, dom_el) ->
    width = window.innerWidth
    width = width / 2
    left_pos = $(dom_el).offset().left
    return "left"  if width < left_pos
    "right"

  $('.day').each ->
    status = $(this).data("status")
    span = $(@).children("span")
    if status == "bouth"
      color = $(this).data("color")
      start_color = color[0]
      end_color = color[1]
      span.css("background", "-webkit-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      span.css("background", "-webkit-gradient(linear, left top, right bottom, color-stop(47%,"+end_color+"), color-stop(48%,#000000), color-stop(52%,000000), color-stop(47%,"+start_color+"))")
      span.css("background", "-moz-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      span.css("background", "-o-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      span.css("background", "-ms-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      span.css("background", "linear-gradient(135deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      span.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='"+end_color+"', endColorstr='"+start_color+"',GradientType=1)")
    else if status == "start"
        color = $(this).data("color")
        span.css("background", "-webkit-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        span.css("background", "-webkit-gradient(linear, right bottom, left top, color-stop(50%,"+color+"), color-stop(50%,#ffffff))")
        span.css("background", "-moz-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        span.css("background", "-o-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        span.css("background", "-ms-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        span.css("background", "linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
        span.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='"+color+"',GradientType=1)")
      else if status == "end"
          color = $(this).data("color")
          span.css("background", "-webkit-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          span.css("background", "-webkit-gradient(linear, left top, right bottom, color-stop(50%,"+color+"), color-stop(50%,#ffffff))")
          span.css("background", "-moz-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          span.css("background", "-o-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          span.css("background", "-ms-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          span.css("background", "linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
          span.css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='"+color+"', endColorstr='#ffffff',GradientType=1)")
        else if status == "between"
            color = $(this).data("color")
            span.css("background", color)

  $(".day").hover ->
    if $(@).data('period-id')
      period_id = $(@).data('period-id')[0] || $(@).data('period-id')
    $(".day[data-period-id^='[#{period_id}']").toggleClass('hover')
    $(".day[data-period-id=#{period_id}][data-status=start]").toggleClass('hover all')
    $(".day[data-period-id=#{period_id}][data-status=between]").toggleClass('hover all')

  $('.calendar-color').wColorPicker
    initColor: $('.header').css('backgroundColor')
    theme: "red"
    mode: "click"
    showSpeed: 200
    hideSpeed: 200
    onSelect: (color) ->
      $('#calendar_color').val(color)

  $('.calendar_color').wColorPicker
    initColor: $('.header').css('backgroundColor')
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
