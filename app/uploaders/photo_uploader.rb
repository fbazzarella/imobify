class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/realty_photos/realty_#{model.realty.id}/photo_#{model.id}"
  end

  process :fix_rotation
  
  version :admin do
    version :thumb do
      process resize_to_fill: [84, 84]
    end
  end
end
