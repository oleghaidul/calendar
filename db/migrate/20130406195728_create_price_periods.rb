class CreatePricePeriods < ActiveRecord::Migration
  def change
    create_table :price_periods do |t|
      t.date :start_date
      t.date :end_date
      t.integer :per_night

      t.timestamps
    end
  end
end
