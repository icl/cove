class AddMoreToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :orig_filename, :string
    add_column :videos, :source_cam, :string
    add_column :videos, :project, :string
    add_column :videos, :created, :datetime
    add_column :videos, :uploaded, :datetime
    add_column :videos, :offset, :integer
    add_column :videos, :location, :string
    add_column :videos, :orig_res, :string
    add_column :videos, :cam_type, :string
  end

  def self.down
    remove_column :videos, :cam_type
    remove_column :videos, :orig_res
    remove_column :videos, :location
    remove_column :videos, :offset
    remove_column :videos, :uploaded
    remove_column :videos, :created
    remove_column :videos, :project
    remove_column :videos, :source_cam
    remove_column :videos, :orig_filename
  end
end
