class AddCurrenyToPricePeriods < ActiveRecord::Migration
  def change
    add_column :price_periods, :currency, :string
  end
end
