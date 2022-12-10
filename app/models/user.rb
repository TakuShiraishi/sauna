class User < ApplicationRecord

  # belongs_to :sauna
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
         #:recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :saunas, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comment_favorites, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

   validates :name, length: { minimum: 2, maximum: 20 },uniqueness: true



  def follow(user)
      relationships.create(followed_id: user.id)
  end

  def unfollow(user)
      relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
      followings.include?(user)
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
   end
  end

  def self.looks(search, name)
    if search == "perfect"
      @user = User.where("name LIKE?", "#{name}")
    　else search == "partial"
      @user = User.where("name LIKE?","#{name}%")
    end
     @user = User.all
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
end
