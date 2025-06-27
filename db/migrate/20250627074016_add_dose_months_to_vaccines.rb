class AddDoseMonthsToVaccines < ActiveRecord::Migration[7.1]
  def change
    add_column :vaccines, :dose_months, :json
  end
end
