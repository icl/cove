class Videocode < ActiveRecord::Base
	belongs_to :video
	belongs_to :code
end
