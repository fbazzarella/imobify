class PhotoUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/realty_photos/realty_#{model.realty.id}/photo_#{model.id}"
  end
end
