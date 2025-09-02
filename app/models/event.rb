class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User"

  has_one_attached :main_image
  has_many_attached :gallery_images
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  validates :name, :event_type, :start_time, :end_time, :description, :address, :location, :event_date, :price, presence: true

  def gallery_image_urls
    gallery_images.map { |img| img.url }
  end

  def main_image_url
    return unless main_image.attached?

    main_image.url
  end
end
