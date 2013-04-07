class PricePeriodsController < ApplicationController
  load_and_authorize_resource
  before_filter :load_calendar

  def create
    @price_period.user_calendar = @calendar
    @price_period.save
    @price_periods = @calendar.price_periods
  end

  def update
    @price_period.user_calendar = @calendar
    @price_period.update_attributes(params[:price_period])
    @price_periods = @calendar.price_periods
  end

  def destroy
    @price_period.destroy
  end

  private
    def load_calendar
      @calendar = UserCalendar.find(params[:calendar_id])
    end
end
