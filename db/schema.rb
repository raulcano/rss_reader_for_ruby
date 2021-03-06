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

ActiveRecord::Schema.define(:version => 20130205195136) do

  create_table "feed_entries", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "feed_source_url"
  end

  add_index "feed_entries", ["feed_source_url"], :name => "index_feed_entries_on_feed_source_url"
  add_index "feed_entries", ["published_at", "created_at"], :name => "index_feed_entries_on_published_at_and_created_at"

  create_table "feed_source_entries", :force => true do |t|
    t.integer  "feed_source_id"
    t.integer  "feed_entry_id"
    t.boolean  "is_starred",     :default => false
    t.boolean  "is_read",        :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "feed_source_entries", ["feed_entry_id"], :name => "index_feed_source_entries_on_feed_entry_id"
  add_index "feed_source_entries", ["feed_source_id", "feed_entry_id"], :name => "altered_feed_source_entries_unique", :unique => true
  add_index "feed_source_entries", ["feed_source_id"], :name => "index_feed_source_entries_on_feed_source_id"

  create_table "feed_sources", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "folder_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feed_sources", ["user_id", "created_at"], :name => "index_feed_sources_on_user_id_and_created_at"

  create_table "filters", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "folders", :force => true do |t|
    t.integer  "parent_id"
    t.string   "title"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "folders", ["depth"], :name => "index_folders_on_depth"
  add_index "folders", ["lft"], :name => "index_folders_on_lft"
  add_index "folders", ["parent_id"], :name => "index_folders_on_parent_id"
  add_index "folders", ["rgt"], :name => "index_folders_on_rgt"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "title"
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
