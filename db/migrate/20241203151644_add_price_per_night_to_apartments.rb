class AddPricePerNightToApartments < ActiveRecord::Migration[7.1]
  def change
    add_column :apartments, :price_per_night, :decimal
  end
end
