class AddMoreToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :orig_filepath, :string #Filename and path as it was from the source ("G:/External/12_31_30/file.mp4")
    add_column :videos, :source_cam, :string #Camera that was used to create the video ("Balanchine")
    add_column :videos, :project, :string #Project the video was created for ("Dance Ethnography Project" "Wiisard")
    add_column :videos, :uploaded, :datetime #when was the file uploaded
    add_column :videos, :offset, :integer #Known clock deviation from the source Camera's internal clock ("3 seconds")
    add_column :videos, :location, :string #Location of filming, not coordinates ("Practice Room")
    add_column :videos, :orig_res, :string #Highest resolution available, the one it was filmed in ("1920x1080, 30fps")
    add_column :videos, :cam_type, :string #Type of camera used to make video ("Canon Vixia HD 880")
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
