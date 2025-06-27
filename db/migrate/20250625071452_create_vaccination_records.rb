class CreateVaccinationRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccination_records do |t|
      t.references :child, null: false, foreign_key: true
      t.integer :vaccine_id
      t.string :other_vaccine_name
      t.string :hospital_name
      t.text :memo
      t.date :scheduled_date
      t.boolean :completed, default: false
      t.date :vaccinated_at

      t.timestamps
    end
  end
end
