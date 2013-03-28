class Period < ActiveRecord::Base
  attr_accessible :calendar_id, :end_date, :info, :note, :period_type, :start_date
  attr_accessor :day
  belongs_to :calendar

  def process
    # TODO: add color field
    # {status: status, color: color, period_id: id}
    {status: status, period_id: id}
  end

  def status
    if start?
      'start'
    elsif end?
      'end'
    else
      'between'
    end
  end

  private

    def start?
      start_date == day
    end

    def end?
      end_date == day
    end
end
