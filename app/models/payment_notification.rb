class PaymentNotification < ActiveRecord::Base
  belongs_to :user_calendar
  serialize :params
  after_create :mark_calendar_as_purchased

  attr_accessible :params, :user_calendar_id, :status, :transaction_id

private
  def mark_calendar_as_purchased
    if status == "Completed"
      user_calendar.make_paid
    end
  end
end