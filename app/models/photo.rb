class Photo < ActiveRecord::Base
  belongs_to :realty

  default_scope { order(:created_at) }

  validates :realty_id, presence: true

  validates :uuid, length: {maximum: 255}

  mount_uploader :file, PhotoUploader

  before_save do
    self.uuid = Time.now.strftime("%Y%m%d%H%M%S-#{SecureRandom.uuid}")
  end

  def to_json
    {
      id:         id,
      thumb_url:  file.admin_thumb.url,
      normal_url: file.admin_normal.url
    }
  end
end
