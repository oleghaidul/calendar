class CalendarColorsController < ApplicationController
  load_and_authorize_resource

  def index
    @calendar = UserCalendar.find(params[:calendar_id])
  end

  def new
    @calendar = UserCalendar.find(params[:calendar_id])
    @color = @calendar.calendar_colors.build
  end

  def create
    @calendar = UserCalendar.find(params[:calendar_id])
    @calendar_color.user_calendar = @calendar
    @calendar_color.save
    respond_with @calendar_color, location: calendar_calendar_colors_url(@calendar)
  end

  def destroy
    @calendar = UserCalendar.find(params[:calendar_id])
    @calendar_color.destroy
    redirect_to calendar_calendar_colors_path(@calendar)
  end
end
