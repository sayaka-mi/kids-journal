class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.text :content
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end
  end
end
