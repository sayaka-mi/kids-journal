class CreateVaccines < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccines do |t|
      t.string :name
      t.text :description
      t.integer :min_month
      t.integer :max_month
      t.boolean :optional
      t.json :dose_months

      t.timestamps
    end
  end
end
