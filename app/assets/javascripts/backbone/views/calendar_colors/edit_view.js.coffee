Calendar.Views.CalendarColors ||= {}

class Calendar.Views.CalendarColors.EditView extends Backbone.View
  template : JST["backbone/templates/calendar_colors/edit"]

  events :
    "submit #edit-calendar_color" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    console.log(@model)
    @model.save({color_name: $('#color_name').val(), color_hash: $('#color_hash').val()},
      success : (calendar_color) =>
        @model = calendar_color
        window.location.hash = "index"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))
    this.$("form").backboneLink(@model)
    @showColorPicker()

    return this

  showColorPicker: ->
    this.$el.find('.calendar_color').wColorPicker
      initColor: @model.attributes.color_hash
      theme: "red"
      showSpeed: 200
      hideSpeed: 200
      onSelect: (color) ->
        $('#color_hash').val(color)

