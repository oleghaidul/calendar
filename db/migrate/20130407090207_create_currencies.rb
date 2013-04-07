class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :country_name
      t.string :name

      t.timestamps
    end
  end
end
