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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150202002713) do

  create_table "comments", force: true do |t|
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "commenter_id"
    t.text     "comment"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.integer  "organizer_id"
    t.string   "name"
    t.text     "location"
    t.datetime "date"
    t.string   "base_game_type"
    t.string   "game_type"
    t.string   "limit_type"
    t.float    "stakes",         limit: 24
    t.float    "buy_in",         limit: 24
    t.float    "re_buy_in",      limit: 24
    t.float    "buy_in_min",     limit: 24
    t.float    "buy_in_max",     limit: 24
    t.integer  "min_players"
    t.integer  "max_players"
    t.text     "info"
    t.text     "players"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", force: true do |t|
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "invited_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.string   "parent_type"
    t.integer  "parent_id"
    t.integer  "requester_id"
    t.string   "request_type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rings", force: true do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.text     "users"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.integer  "organizer_id"
    t.text     "location"
    t.datetime "arrival_date"
    t.datetime "departure_date"
    t.boolean  "is_chop_room"
    t.integer  "max_players"
    t.text     "players"
    t.boolean  "notify_rings"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "favorite_hand"
    t.string   "avatar_url"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "notify_via"
    t.text     "bio"
    t.string   "share"
    t.boolean  "is_admin"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
