class Child < ApplicationRecord
  belongs_to :user
  has_many :records, dependent: :destroy
  has_many :vaccination_records, dependent: :destroy
  has_many :height_weights, dependent: :destroy

  enum gender: { male: 0, female: 1 }
  enum blood_type: { A: 'A', B: 'B', O: 'O', AB: 'AB', unknown: 'unknown' }

  validates :name, :birthday, :gender, :blood_type, presence: true

  def age_in_years_and_months
    return unless birthday

    today = Date.current
    years = today.year - birthday.year
    months = today.month - birthday.month
    days = today.day - birthday.day

    if days < 0
      months -= 1
    end
    if months < 0
      years -= 1
      months += 12
    end

    "#{years}歳#{months}か月"
  end

end
