class Vaccine < ApplicationRecord
  has_many :vaccination_records, dependent: :nullify
end
