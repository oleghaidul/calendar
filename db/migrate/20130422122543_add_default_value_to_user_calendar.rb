class AddDefaultValueToUserCalendar < ActiveRecord::Migration
  def change
    change_column :user_calendars, :color, :string, default: '#D5EBDA'
  end
end
