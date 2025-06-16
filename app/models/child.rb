class Child < ApplicationRecord
  belongs_to :user

  enum gender: { male: 0, female: 1 }

  validates :name, :birthday, :gender, presence: true
  validates :name, format: { with: /\S/, message:"を入力してください！"}
end
