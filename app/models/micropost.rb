class Micropost < ApplicationRecord
  belongs_to :user
  default_scope ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:
    Settings.micropost.content.max_length}
  validate :picture_size
  scope :of_feed, ->(following_ids){where user_id: following_ids}

  private

  def picture_size
    return unless picture.size > 5.megabytes
    errors.add :picture, "should be less than 5MB"
  end
end
