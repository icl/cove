class CreateTrainingTags < ActiveRecord::Migration
  def self.up
    create_table :training_tags do |t|
      t.integer :training_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :training_tags
  end
end
