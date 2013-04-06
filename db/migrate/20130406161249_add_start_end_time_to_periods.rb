class AddStartEndTimeToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :start_time, :string
    add_column :periods, :end_time, :string
  end
end
