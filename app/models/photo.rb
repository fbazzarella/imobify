class Photo < ActiveRecord::Base
  belongs_to :realty

  validates :realty_id, presence: true

  mount_uploader :file, PhotoUploader

  def to_json
    {id: id, thumb_url: file.admin.thumb.url}
  end
end
