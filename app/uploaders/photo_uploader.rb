class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/realty_photos/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process :fix_rotation

  version :cover do
    process resize_to_fill: [440, 330]
  end

  version :normal do
    process resize_to_fit: [960, 540]
  end

  version :admin_thumb do
    process resize_to_fill: [93, 93]
  end

  version :admin_cover do
    process resize_to_fill: [768, 150]
  end
end
