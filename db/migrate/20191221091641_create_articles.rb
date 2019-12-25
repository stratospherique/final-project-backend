class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :description
      t.decimal :price
      t.string  :preview
      t.string :buildingType
      t.string :propertyType
      t.string :city
      t.decimal :footage
      t.integer :rating
      t.timestamps
    end
  end
end
