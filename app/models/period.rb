class Period < ActiveRecord::Base
  attr_accessible :calendar_id, :end_date, :info, :note, :period_type, :start_date
  attr_accessor :day
  belongs_to :calendar

  def process
    {status: period.status, color: period.color, period_id: period.id}
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
      period.start_date == day
    end

    def end?
      period.end_date == day
    end
end
