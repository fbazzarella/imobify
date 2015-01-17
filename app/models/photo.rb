class Photo < ActiveRecord::Base
  belongs_to :realty

  validates :realty_id, presence: true

  mount_uploader :file, PhotoUploader
end
