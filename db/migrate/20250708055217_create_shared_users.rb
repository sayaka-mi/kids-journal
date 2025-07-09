class CreateSharedUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :shared_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shared_user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :shared_users, [:user_id, :shared_user_id], unique: true
  end
end
