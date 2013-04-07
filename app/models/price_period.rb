class PricePeriod < ActiveRecord::Base
  attr_accessible :end_date, :per_night, :start_date, :currency_id

  validates :start_date, :end_date, :per_night, presence: true
  validates :start_date, :end_date, :overlap => {:scope => "user_calendar_id"}

  belongs_to :user_calendar
  belongs_to :currency

  delegate :name, to: :currency, prefix: true, allow_nil: true

end
