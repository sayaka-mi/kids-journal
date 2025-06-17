class CreateChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :children do |t|
      t.string :name, null: false
      t.date :birthday, null: false
      t.integer :gender, null: false
      t.text :allergy_info
      t.string :blood_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
