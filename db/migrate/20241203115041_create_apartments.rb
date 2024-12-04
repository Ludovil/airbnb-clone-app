class CreateApartments < ActiveRecord::Migration[7.1]
  def change
    create_table :apartments do |t|
      t.string :address
      t.boolean :availability
      t.string :photos
      t.decimal :price_per_night
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
