class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :calendar_id
      t.date :start_date
      t.date :end_date
      t.string :period_type
      t.text :info
      t.text :note

      t.timestamps
    end
  end
end
