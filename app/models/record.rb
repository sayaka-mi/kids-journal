class Record < ApplicationRecord
  belongs_to :child
  has_many_attached :images
  has_many :record_tags, dependent: :destroy
  has_many :tags, through: :record_tags

  validates :content, length: { maximum: 500 }, allow_blank: true

  validate :images_or_content_presence
  validate :valid_image_types

  def self.search(child_ids:, tag_names:, content:)
    return none if tag_names.to_s.strip.blank? && content.to_s.strip.blank?
    
    records = where(child_id: child_ids)
    if tag_names.present?
      tag_list = tag_names.split(/[\s,　]+/).map(&:strip)
      records = records.joins(:tags).where(tags: { name: tag_list }).distinct
    end
    if content.present?
      records = records.where("content LIKE ?", "%#{sanitize_sql_like(content)}%")
    end
    records.includes(:tags, images_attachments: :blob).order(created_at: :desc)
  end

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
