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

ActiveRecord::Schema.define(version: 20150912162851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: true do |t|
    t.integer  "pick_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["pick_id", "user_id"], name: "index_favorites_on_pick_id_and_user_id", unique: true, using: :btree
  add_index "favorites", ["pick_id"], name: "index_favorites_on_pick_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "picks", force: true do |t|
    t.string   "pronostico"
    t.string   "deporte"
    t.float    "cuota"
    t.string   "categoria"
    t.string   "evento"
    t.float    "stake"
    t.text     "explicacion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "status",      default: "unstarted"
    t.string   "result",      default: "fail"
    t.datetime "pickdate"
  end

  add_index "picks", ["user_id", "created_at"], name: "index_picks_on_user_id_and_created_at", using: :btree
  add_index "picks", ["user_id"], name: "index_picks_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "stats", force: true do |t|
    t.float    "acierto",     default: 0.0
    t.float    "yield",       default: 0.0
    t.integer  "acertadas",   default: 0
    t.integer  "falladas",    default: 0
    t.integer  "anuladas",    default: 0
    t.integer  "totalpicks",  default: 0
    t.float    "profit",      default: 0.0
    t.float    "totalstaked", default: 0.0
    t.float    "cuotaavg",    default: 0.0
    t.float    "totalcuota",  default: 0.0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["user_id"], name: "index_stats_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "pro",               default: 0
    t.boolean  "admin",             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "usuarios", force: true do |t|
    t.string   "login"
    t.string   "pass"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
