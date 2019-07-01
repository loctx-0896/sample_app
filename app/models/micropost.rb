class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  scope :news_feed, ->{order created_at: :desc}
  scope :feed_by_id, ->(ids){where user_id: ids}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.maximum}
  validate :picture_size

  private
  def picture_size
    return unless picture.size > Settings.max_size_picture.megabytes
    errors.add(:picture, t("model.micropost.size_image"))
  end
end
