class RenameCalendarIdColumnFromPeriods < ActiveRecord::Migration
  def change
    rename_column :periods, :calendar_id, :user_calendar_id
  end
end
