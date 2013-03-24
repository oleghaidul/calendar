class UserCalendar < ActiveRecord::Base
  attr_accessible :active, :name, :paid, :periods_attributes

  has_many :periods, foreign_key: :calendar_id
  accepts_nested_attributes_for :periods
end
