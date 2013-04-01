class PeriodsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_calendar, only: [:new, :edit]

  respond_to :js

  def new
    @period = @calendar.periods.build
  end

  def edit
  end

  def create
    @calendar = UserCalendar.find(params[:period][:calendar_id])
    if @period.save
      respond_with @period, location: edit_calendar_url(@calendar)
    else
      respond_with @period
    end
  end

  def update
    @calendar = UserCalendar.find(params[:period][:calendar_id])
    @period.update_attributes(params[:period])
    respond_with @period, location: edit_calendar_url(@calendar)
  end

  private

    def find_calendar
      @calendar = UserCalendar.find(params[:calendar_id])
    end
end
