class HeightWeight < ApplicationRecord
  belongs_to :child

  validates :recorded_on, presence: true
  validates :height, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :weight, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validate :height_or_weight_presence

  before_validation :set_default_recorded_on, on: :create

  def age_in_months
    child.age_in_months_at(recorded_on)
  end

  private

  def set_default_recorded_on
    self.recorded_on ||= Date.current
  end

  def height_or_weight_presence
    if height.blank? && weight.blank?
      errors.add(:base, "身長か体重のどちらかを入力してください")
    end
  end
end
