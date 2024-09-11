class CreateShoeModels < ActiveRecord::Migration[7.2]
  def change
    create_table :shoe_models do |t|
      t.string :name
      t.integer :inventory
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
