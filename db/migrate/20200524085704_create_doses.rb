class CreateDoses < ActiveRecord::Migration[6.0]
  def change
    create_table :doses do |t|
      t.references :cocktail, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end

    add_index :doses, [:cocktail_id, :ingredient_id], unique: true
  end
end
