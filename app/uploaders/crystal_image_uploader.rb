# encoding: utf-8

class CrystalImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  
  process :resize_to_fit => [250, 250]

  version :big_thumb do
    process :resize_to_limit => [80, 80]
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def store_dir
    'uploads'
  end


end
