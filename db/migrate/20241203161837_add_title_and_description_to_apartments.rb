class AddTitleAndDescriptionToApartments < ActiveRecord::Migration[7.1]
  def change
    add_column :apartments, :title, :string
    add_column :apartments, :description, :text
  end
end
