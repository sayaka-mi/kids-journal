class Child < ApplicationRecord
  belongs_to :user

  enum gender: { male: 0, female: 1 }
  enum blood_type: { A: 'A', B: 'B', O: 'O', AB: 'AB', unknown: 'unknown' }

  validates :name, :birthday, :gender, :blood_type, presence: true
  validates :name, format: { with: /\S/, message:"を入力してください！"}
end
