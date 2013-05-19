Calendar.Views.CalendarColors ||= {}

class Calendar.Views.CalendarColors.ShowView extends Backbone.View
  template: JST["backbone/templates/calendar_colors/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
