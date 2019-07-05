class TourUploader < CarrierWave::Uploader::Base
  storage :file
  def store_dir
    "app/assets/tour"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def size_range
    1..10.megabytes
  end
end
