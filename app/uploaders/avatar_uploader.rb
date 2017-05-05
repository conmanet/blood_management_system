class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" +
      [version_name, "default.png"].compact.join('_'))
  end

  version :thumb do
    process resize_to_fit: [64, 64]
  end

  version :medium do
    process resize_to_fit: [200, 200]
  end

  version :small do
    process resize_to_fit: [32, 32]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
