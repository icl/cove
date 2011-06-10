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
    begin
      Indexer.update_index :type => "tag:#{Rails.env}", :term => self.tag.name.downcase, :db_id => self.id
    rescue
      Rails.logger.warn('Could not access index server')
    end
  end

  def self.search(query)
    results = Indexer.search(:type => "tag:#{Rails.env}", :query => query.downcase)
    self.where(:id => results)
  end

end
