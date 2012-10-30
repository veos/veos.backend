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

ActiveRecord::Schema.define(:version => 20121030205526) do

  create_table "installations", :force => true do |t|
    t.string  "compliance_level_override"
    t.text    "compliance_note"
    t.integer "organization_id"
    t.string  "jurisdiction"
  end

  add_index "installations", ["organization_id"], :name => "index_installations_on_organization_id"

  create_table "organizations", :force => true do |t|
    t.string "name"
    t.string "org_type"
    t.string "privacy_officer_name"
    t.string "privacy_officer_email"
    t.string "privacy_officer_telephone"
    t.text   "privacy_officer_note"
    t.string "privacy_officer_address"
  end

  create_table "photo_tags", :force => true do |t|
    t.integer "photo_id"
    t.string  "tag"
  end

  add_index "photo_tags", ["photo_id"], :name => "index_photo_tags_on_photo_id"

  create_table "photos", :force => true do |t|
    t.integer  "report_id"
    t.text     "notes"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_fingerprint"
  end

  add_index "photos", ["report_id"], :name => "index_photos_on_report_id"

  create_table "report_tags", :force => true do |t|
    t.integer  "report_id"
    t.string   "tag"
    t.string   "tag_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "report_tags", ["report_id"], :name => "index_sign_tags_on_report_id"

  create_table "reports", :force => true do |t|
    t.integer  "installation_id"
    t.float    "loc_lat_from_gps"
    t.float    "loc_lng_from_gps"
    t.string   "loc_description_from_google"
    t.float    "loc_lat_from_user"
    t.float    "loc_lng_from_user"
    t.string   "loc_description_from_user"
    t.boolean  "owner_identifiable"
    t.string   "owner_name"
    t.string   "owner_type"
    t.string   "operator_name"
    t.integer  "camera_count"
    t.boolean  "has_sign"
    t.text     "sign_text"
    t.string   "sign_visibility"
    t.text     "notes"
    t.string   "contributor_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.boolean  "flagged"
    t.datetime "flagged_on"
    t.string   "flagged_by"
    t.text     "flagged_reason"
  end

  add_index "reports", ["installation_id"], :name => "index_reports_on_installation_id"

  add_foreign_key "installations", "organizations", :name => "installations_organization_id_fk", :dependent => :nullify

  add_foreign_key "photo_tags", "photos", :name => "photo_tags_photo_id_fk", :dependent => :delete

  add_foreign_key "photos", "reports", :name => "photos_report_id_fk", :dependent => :nullify

  add_foreign_key "report_tags", "reports", :name => "sign_tags_report_id_fk", :dependent => :delete

  add_foreign_key "reports", "installations", :name => "reports_installation_id_fk", :dependent => :nullify

end
