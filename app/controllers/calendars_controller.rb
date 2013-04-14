class CalendarsController < ApplicationController
  layout 'clear', only: :show
  helper LaterDude::CalendarHelper
  load_and_authorize_resource :user_calendar, instance_name: :calendar, parent: false
  respond_to :js, only: :new

  def index
    @calendars = current_user.user_calendars
  end

  def new
    @periods = @calendar.periods.build
  end

  def edit
    @colors = @calendar.periods_colors
    @current_year = params[:year] || DateTime.now.year
    @price_periods = @calendar.price_periods
  end

  def show
    @colors = @calendar.periods_colors
    @current_year = params[:year] || DateTime.now.year
  end

  def create
    @calendar.attributes = params[:calendar]
    if @calendar.save
      respond_with @calendar, location: edit_calendar_url(@calendar)
    else
      respond_with @calendar
    end
  end

  def update
    @calendar.update_attributes(params[:calendar])
    respond_with @calendar, location: edit_calendar_url(@calendar)
  end

  def make_paid
    if @calendar.return_hex == params[:return_hex]
      @calendar.make_paid
      redirect_to edit_calendar_url(@calendar)
    else
      redirect_to edit_calendar_url(@calendar), notice: "Invalid payment identifier"
    end
  end

  def list
    @calendars = current_user.user_calendars
    @calendars = @calendars.where(paid: true)
  end
end
