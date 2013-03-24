class AddUserIdToUserCalendars < ActiveRecord::Migration
  def change
    add_column :user_calendars, :user_id, :integer
  end
end
