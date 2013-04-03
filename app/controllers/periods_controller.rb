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
    @calendar = UserCalendar.find(params[:period][:user_calendar_id])
    @colors = @calendar.periods.order { created_at }.collect { |p| [p.color_name, p.color] }.uniq
    if @period.save
      respond_with @period, location: edit_calendar_url(@calendar)
    else
      redirect_to edit_calendar_url(@calendar), notice: @period.errors.full_messages.join(', ')
    end
  end

  def update
    @calendar = UserCalendar.find(params[:period][:user_calendar_id])
    @period.update_attributes(params[:period])
    respond_with @period, location: edit_calendar_url(@calendar)
  end

  private

    def find_calendar
      @calendar = UserCalendar.find(params[:calendar_id])
    end
end
