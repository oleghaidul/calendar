class AddFieldsToUserCalendar < ActiveRecord::Migration
  def change
    add_column :user_calendars, :trial_to, :datetime
    add_column :user_calendars, :trial, :boolean
    add_column :user_calendars, :paid_to, :datetime
  end
end
