class Sauna < ApplicationRecord
 belongs_to :user
 has_many :favorites, dependent: :destroy
 has_many :comments, dependent: :destroy
 has_many :review, dependent: :destroy
 has_one_attached :profile_image


  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
