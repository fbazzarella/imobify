class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/realty_photos/realty_#{model.realty.id}/photo_#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process :fix_rotation
  
  version :admin do
    version :thumb do
      process resize_to_fill: [84, 84]
    end

    version :normal do
      process resize_to_fit: [960, 540]
    end

    version :normal_2x do
      process resize_to_fit: [1920, 1080]
    end
  end
end
