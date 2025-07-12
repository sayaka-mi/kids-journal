class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :children, dependent: :destroy

  has_many :shared_users, dependent: :destroy
  has_many :shared_with_users, through: :shared_users, source: :shared_user
  has_many :inverse_shared_users, class_name: 'SharedUser', foreign_key: 'shared_user_id', dependent: :destroy
  has_many :shared_from_users, through: :inverse_shared_users, source: :user

  validates :name, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字をそれぞれ1文字以上含めて入力してください！' },
                       allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'の形式が正しくありません！' }, allow_blank: true
end
