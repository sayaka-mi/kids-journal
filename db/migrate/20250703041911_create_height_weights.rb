class CreateHeightWeights < ActiveRecord::Migration[7.1]
  def change
    create_table :height_weights do |t|
      t.references :child, null: false, foreign_key: true
      t.date :recorded_on, null: false
      t.float :height
      t.float :weight

      t.timestamps
    end
  end
end
