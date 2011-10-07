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

ActiveRecord::Schema.define(:version => 20111004132709) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "date"
    t.integer  "subscribers"
    t.integer  "friends"
    t.text     "mail"
    t.datetime "start_subscribe"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "randinfo"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "positie"
    t.boolean  "locked"
    t.boolean  "only_gedoopten"
    t.boolean  "only_leden"
    t.boolean  "inactief"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "vrienden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upload_files", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "upload_folder_id"
    t.string   "filename"
    t.string   "link"
  end

  create_table "upload_folders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.string   "unlock_token"
    t.datetime "locked_at"
		t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "sign_in_count"
    t.integer "failed_attempts"
  end

end
