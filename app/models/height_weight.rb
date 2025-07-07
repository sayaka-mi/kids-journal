class HeightWeight < ApplicationRecord
  belongs_to :child

  validates :recorded_on, presence: true
  validates :height, presence: true, if: -> { weight.blank? }
  validates :weight, presence: true, if: -> { height.blank? }
  validates :height, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :weight, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  after_initialize do
    set_default_recorded_on if new_record?
  end

  def age_in_months
    child.age_in_months_at(recorded_on)
  end

  private

  def set_default_recorded_on
    self.recorded_on ||= Date.current
  end
end
