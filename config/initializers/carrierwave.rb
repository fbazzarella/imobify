module CarrierWave
  module MiniMagick
    def fix_rotation
      manipulate! do |img|
        img.auto_orient
        img = yield(img) if block_given?
        img
      end
    end
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  PhotoUploader

  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?

    klass.class_eval do
      def cache_dir
        "#{Rails.root}/tmp/uploads"
      end

      def store_dir
        "#{Rails.root}/tmp/uploads/#{model.id}"
      end
    end
  end
end
