class PeriodsController < ApplicationController
  load_and_authorize_resource

  respond_to :js

  def new
    @calendar = UserCalendar.find(params[:calendar_id])
    @period = @calendar.periods.build
  end

  def create
    @calendar = UserCalendar.find(params[:period][:calendar_id])
    if @period.save
      respond_with @period, location: edit_calendar_url(@calendar)
    else
      respond_with @period
    end
  end
end
