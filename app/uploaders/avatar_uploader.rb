class AvatarUploader < CarrierWave::Uploader::Base
  storage :file
  def store_dir
    "app/assets/avatar"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def size_range
    1..10.megabytes
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) ||
      model.instance_variable_set(var, SecureRandom.uuid)
  end
end
