class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
    has_many :comments
    has_many :replies, class_name: 'Reply', foreign_key: :user_id, dependent: :destroy
    default_scope -> { order(created_at: :desc) }
    mount_uploader :picture, PictureUploader
    validates :title, presence: true, length: { maximum: 50 }
    validates :content, presence: true, length: { maximum: 255 }
    validates :user_id, presence: true
    validate  :picture_size
    
    def self.search(keyword)
      where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
    end
    
    private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
