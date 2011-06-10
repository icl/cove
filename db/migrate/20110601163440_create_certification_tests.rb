class CreateCertificationTests < ActiveRecord::Migration
  def self.up
    create_table :certification_tests do |t|
      t.references :certification_video
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :certification_tests
  end
end
