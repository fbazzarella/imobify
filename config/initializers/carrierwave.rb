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
