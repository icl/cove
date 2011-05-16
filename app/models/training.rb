class Training < ActiveRecord::Base
	has_many :training_tags
	has_many :tags, :through => :training_tags
	has_many :training_videos
	has_many :video_trainings, :through => :training_videos

   validates :title, :presence => true,
                     :uniqueness => true, 
                     :length   => { :maximum => 50 }

   validates :description, 
                     :presence => true,
                     :length   => { :maximum => 255 }

   validates_presence_of :training_videos
   validates_presence_of :training_tags

	def video_names 
		video_trainings.map{|v| v.name}
	end

	def tag_names
		tags.map{|t| t.name}
	end
end
