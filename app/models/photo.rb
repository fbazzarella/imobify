class Photo < ActiveRecord::Base
  belongs_to :realty

  default_scope { order(:created_at) }

  validates :realty_id, presence: true

  mount_uploader :file, PhotoUploader

  def to_json
    {
      id:         id,
      thumb_url:  file.admin.thumb.url,
      normal_url: file.admin.normal.url
    }
  end
end
