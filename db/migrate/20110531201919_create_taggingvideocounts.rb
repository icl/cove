class CreateTaggingvideocounts < ActiveRecord::Migration
  def self.up
    create_table :taggingvideocounts do |t|

      t.references :tag
      t.references :video
      t.integer :applied_count, :default => 1
      t.timestamps
    end
    add_index :taggingvideocounts, :tag_id
    add_index :taggingvideocounts ,:video_id
    add_index :taggingvideocounts, :applied_count
  end

  def self.down
    drop_table :taggingvideocounts
  end
end
