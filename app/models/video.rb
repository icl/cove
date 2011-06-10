class Video < ActiveRecord::Base
  attr_accessible :filepath, :name, :duration, :source_cam, :project, :cam_type, :location, :orig_res, :starttime, :created_at, :updated_at, :orig_filepath, :source_cam, :project, :comments
  #mount uploader for carrierwave
  mount_uploader :video_up, VideoFileUploader

	has_many :job_videos
	has_many :jobs, :through => :job_videos
	has_many :video_tags
	has_many :tags, :through => :video_tags

  def self.method_missing(method_name, *args)
    if  (result = method_name.to_s.match(/unique_(\w*)/))
      attribute = result.captures[0]
      attribute = attribute.singularize
      records = self.select("DISTINCT #{attribute}")
      return records.map {|r| r.send(attribute.to_sym) }
    else
      super
    end
  end

  def self.search(query)
    results = Indexer.search(:type => "tag:#{Rails.env}", :query => query.downcase)
    self.joins(:video_tags).where("video_tags.id IN (?)", results)
  end
  

end
