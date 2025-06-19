class Record < ApplicationRecord
  belongs_to :child
  has_one_attached :image

  validate :image_or_content_presence
  validate :image_content_type

  private

  def image_or_content_presence
    if !image.attached? && content.blank?
      errors.add(:base, "どちらかを記録してみましょう！")
    end
  end

  def image_content_type
    return unless image.attached?
    acceptable_types = ["image/jpeg", "image/png", "image/gif", "video/mp4", "video/quicktime"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "は対応している画像または動画ファイルでアップロードしてください")
    end
  end
end
