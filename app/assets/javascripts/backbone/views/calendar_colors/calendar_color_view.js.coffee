Calendar.Views.CalendarColors ||= {}

class Calendar.Views.CalendarColors.CalendarColorView extends Backbone.View
  template: JST["backbone/templates/calendar_colors/calendar_color"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
