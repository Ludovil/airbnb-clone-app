class AddTitleToApartments < ActiveRecord::Migration[7.1]
  def change
    add_column :apartments, :title, :string
  end
end
