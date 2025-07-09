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

  def age_in_months_at(date)
    return nil unless birthday
    
    target_date = date.to_date
    years = target_date.year - birthday.year
    months = target_date.month - birthday.month
    days = target_date.day - birthday.day
    
    if days < 0
      months -= 1
      prev_month = target_date.beginning_of_month - 1.day
      days_in_prev_month = prev_month.end_of_month.day
      days += days_in_prev_month
    end
    
    if months < 0
      years -= 1
      months += 12
    end
    
    total_months = years * 12 + months
    day_fraction = days / 30.44
    
    (total_months + day_fraction).round(1)
  end

  def current_age_in_months
    age_in_months_at(Date.current)
  end

end
