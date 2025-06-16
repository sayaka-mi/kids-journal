class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :children

  validates :name, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i , message: "は半角英数字をそれぞれ1文字以上含めて入力してください！"}, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "の形式が正しくありません！" }, allow_blank: true
end
