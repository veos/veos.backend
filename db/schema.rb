# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120417145314) do

  create_table "camera_spaces", :force => true do |t|
    t.integer  "camera_id",  :null => false
    t.string   "space",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "camera_spaces", ["camera_id"], :name => "camera_spaces_camera_id_fk"

  create_table "cameras", :force => true do |t|
    t.integer  "report_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cameras", ["report_id"], :name => "cameras_report_id_fk"

  create_table "photos", :force => true do |t|
    t.integer  "of_object_id"
    t.string   "of_object_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "reports", :force => true do |t|
    t.float    "loc_lat_from_gps"
    t.float    "loc_lng_from_gps"
    t.string   "loc_description_from_google"
    t.float    "loc_lat_from_user"
    t.float    "loc_lng_from_user"
    t.string   "loc_description_from_user"
    t.string   "owner_name"
    t.string   "owner_description"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "sign_stated_properties", :force => true do |t|
    t.integer  "sign_id",    :null => false
    t.string   "property",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sign_stated_properties", ["sign_id"], :name => "sign_stated_properties_sign_id_fk"

  create_table "sign_stated_purposes", :force => true do |t|
    t.integer  "sign_id",    :null => false
    t.string   "purpose",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sign_stated_purposes", ["sign_id"], :name => "sign_stated_purposes_sign_id_fk"

  create_table "signs", :force => true do |t|
    t.integer  "report_id",  :null => false
    t.text     "text"
    t.string   "visibility"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "signs", ["report_id"], :name => "signs_report_id_fk"

  add_foreign_key "camera_spaces", "cameras", :name => "camera_spaces_camera_id_fk", :dependent => :delete

  add_foreign_key "cameras", "reports", :name => "cameras_report_id_fk", :dependent => :delete

  add_foreign_key "sign_stated_properties", "signs", :name => "sign_stated_properties_sign_id_fk", :dependent => :delete

  add_foreign_key "sign_stated_purposes", "signs", :name => "sign_stated_purposes_sign_id_fk", :dependent => :delete

  add_foreign_key "signs", "reports", :name => "signs_report_id_fk", :dependent => :delete

end
