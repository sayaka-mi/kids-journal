class Record < ApplicationRecord
  belongs_to :child
  has_many_attached :images
  has_many :record_tags, dependent: :destroy
  has_many :tags, through: :record_tags

  validates :content, length: { maximum: 500 }, allow_blank: true

  validate :images_or_content_presence
  validate :valid_image_types

  private

  def images_or_content_presence
    return if content.present? || images.attached?
    errors.add(:base, "どちらかを記録してみましょう！")
  end

  def valid_image_types
    return unless images.attached?

    acceptable_types = ["image/jpeg", "image/png", "image/gif"]
    images.each do |image|
      unless acceptable_types.include?(image.content_type)
        errors.add(:images, "は対応している画像でアップロードしてください")
      end
    end
  end
  
end
