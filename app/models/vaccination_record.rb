class VaccinationRecord < ApplicationRecord
  belongs_to :child
  belongs_to :vaccine, optional: true

  validates :vaccine_id, numericality: { only_integer: true }, allow_nil: true
  validate :vaccine_id_or_other_vaccine_name_present
  validate :vaccinated_at_required_if_completed

  scope :completed, -> { where(completed: true) }
  scope :scheduled, -> { where(completed: false) }

  before_save :set_completed

  def vaccine_name
    vaccine&.name || other_vaccine_name
  end

  def set_completed
    self.completed = vaccinated_at.present?
  end

  private

  def vaccine_id_or_other_vaccine_name_present
    return unless vaccine_id.blank? && other_vaccine_name.blank?

    errors.add(:base, 'ワクチン名またはその他のワクチン名を入力してください')
  end

  def vaccinated_at_required_if_completed
    return unless completed && vaccinated_at.blank?

    errors.add(:vaccinated_at, '接種日を入力してください（接種済みの場合）')
  end
end
