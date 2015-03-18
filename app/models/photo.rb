class Photo < ActiveRecord::Base
  belongs_to :realty, required: true

  default_scope { order(:created_at) }

  mount_uploader :file, PhotoUploader

  def to_json
    {
      id:         id,
      thumb_url:  file.admin_thumb.url,
      normal_url: file.normal.url
    }
  end
end
