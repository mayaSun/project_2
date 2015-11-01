# encoding: utf-8

class SproutMedicinalHerbImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  
  process :resize_to_fit => [200, 200]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def store_dir
    'uploads'
  end


end