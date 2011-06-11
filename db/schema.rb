# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110610192433) do

  create_table "certification_test_tags", :force => true do |t|
    t.integer  "certification_test_id"
    t.integer  "tag_id"
    t.decimal  "start_time"
    t.decimal  "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certification_tests", :force => true do |t|
    t.integer  "certification_video_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certification_videos", :force => true do |t|
    t.integer  "certification_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seeder_id"
  end

  create_table "certifications", :force => true do |t|
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cheeses", :force => true do |t|
    t.string   "name"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_tags", :force => true do |t|
    t.integer  "job_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_videos", :force => true do |t|
    t.integer  "job_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.float    "budget"
    t.float    "spent"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "requestor_id"
    t.integer  "user_id"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "taggingvideocounts", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "video_id"
    t.integer  "applied_count", :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggingvideocounts", ["applied_count"], :name => "index_taggingvideocounts_on_applied_count"
  add_index "taggingvideocounts", ["tag_id"], :name => "index_taggingvideocounts_on_tag_id"
  add_index "taggingvideocounts", ["video_id"], :name => "index_taggingvideocounts_on_video_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "training_tags", :force => true do |t|
    t.integer  "training_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_videos", :force => true do |t|
    t.integer  "training_id"
    t.integer  "video_training_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_certifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "certification_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",     :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind",                                  :default => "turk"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "video_tags", :force => true do |t|
    t.integer  "video_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_id"
    t.integer  "user_id"
    t.decimal  "start_time"
    t.decimal  "end_time"
  end

  create_table "video_trainings", :force => true do |t|
    t.string   "name"
    t.string   "filepath"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "name"
    t.string   "filepath"
    t.float    "duration"
    t.datetime "starttime"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "orig_filepath"
    t.string   "source_cam"
    t.string   "project"
    t.datetime "uploaded"
    t.integer  "offset"
    t.string   "location"
    t.string   "orig_res"
    t.string   "cam_type"
    t.string   "video_up"
  end

  create_table "work_records", :force => true do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
