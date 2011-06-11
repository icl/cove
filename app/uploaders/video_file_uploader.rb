# encoding: utf-8

class VideoFileUploader < CarrierWave::Uploader::Base


  storage :file

def store_dir
    '../videos'
end
  

end
