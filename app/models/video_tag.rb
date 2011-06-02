class VideoTag < ActiveRecord::Base
	belongs_to :video
	belongs_to :tag
	belongs_to :user
	belongs_to :job

  after_create :index_tag

	def length
		end_time - start_time
	end

	def length=(newlen)
		st = read_attribute(:start_time)
		write_attribute(:end_time, st + newlen)
	end

  def index_tag
    Indexer.update_index :type => "tag", :term => self.tag.name, :db_id => self.id
  end

end
