class Picture < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  mount_uploader :image, ImageUploader
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
