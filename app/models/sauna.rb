class Sauna < ApplicationRecord
 belongs_to :user
  validates :prefecrure,:name,:temprature,:post_code,:price,:time,presence:true
  validates :comment,presence:true,length:{maximum:200}
 has_one_attached :profile_image
 has_many :favorites, dependent: :destroy
 has_many :comments, dependent: :destroy

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end



  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def self.looks(prefecture)
    where("prefecture LIKE ?","%#{prefecture}%")
  end
end