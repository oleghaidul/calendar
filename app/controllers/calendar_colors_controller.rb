class CalendarColorsController < ApplicationController
  load_and_authorize_resource
  respond_to :json

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

  def update
    @calendar = UserCalendar.find(params[:calendar_id])
    @calendar_color = CalendarColor.find(params[:id])
    @calendar_color.update_attributes(params[:calendar_color])
    @calendar_color.save
    respond_with @calendar_color, location: calendar_calendar_colors_url(@calendar)
  end

  def destroy
    @calendar = UserCalendar.find(params[:calendar_id])
    if @calendar.periods.where(calendar_color_id: @calendar_color.id).count == 0
      @calendar_color.destroy
      redirect_to calendar_calendar_colors_path(@calendar), notice: "Color was successfully deleted."
    else
      redirect_to calendar_calendar_colors_path(@calendar), alert: "Can not delete used color."
    end
  end
end
