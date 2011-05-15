class Video < ActiveRecord::Base
  attr_accessible :filepath, :name, :video_id
  #mount uploader for carrierwave
  mount_uploader :video_up, VideoFileUploader

	has_many :job_videos
	has_many :jobs, :through => :job_videos
	has_many :video_tags
	has_many :tags, :through => :video_tags

  def self.add_file args
    @video = Video.new

    #if parameters present in URI
    #if params[:file,:name,:duration,:etc etc...] all in one?
    if params[:file].exists? 
      @video.video_up = params[:file]
      @video.video_up = File.open('CHANGEME')  #Carrierwave readme says to do this... i don't know why
      @video.save!
      @video.video_up.url
      @video.video_up.current_path
    end
    #a bunch of ifs so each param is specific, or if something wants a special action. not necessary but what the hell...
    if params[:name].exists?
      @video.name = :name
    end
    #if params[:content_type].exists?
    #  @video.content_type = :content_type
    #end
    if params[:project].exists?
      @video.project = :project
    end
    if params[:length].exists?
      @video.duration = :length
    end
    if params[:creationdate].exists?
      @video.starttime = :creationdate
    end
    if params[:uploaddate].exists?
      @video.uploaded = :uploaddate
    end
    if params[:camera].exists?
      @video.source_cam = :camera
    end
    if params[:location].exists?
      @video.location = :location
    end
    if params[:orig_res].exists?
      @video.orig_res = :orig_res
    end
    if params[:origfile].exists?
      @video.orig_filepath = :origfile
    end
    if params[:cam_type].exists?
      @video.cam_type = :cam_type
    end
    if params[:offset].exists?
      @video.offset = :offset
    end
  end
end
