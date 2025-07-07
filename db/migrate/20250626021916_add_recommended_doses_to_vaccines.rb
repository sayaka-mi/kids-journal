class AddRecommendedDosesToVaccines < ActiveRecord::Migration[7.1]
  def change
    add_column :vaccines, :recommended_doses, :integer
  end
end