class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :quantity
      t.belongs_to :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
