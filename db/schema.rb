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

ActiveRecord::Schema.define(version: 20150317031055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "theme"
  end

  create_table "cities", force: :cascade do |t|
    t.integer  "country_id"
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.boolean  "principal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "initial",    limit: 255
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "host"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "domains", ["host"], name: "index_domains_on_host", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "realty_id"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "realties", force: :cascade do |t|
    t.string   "reference",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.integer  "country_id"
    t.string   "neighborhood",   limit: 255
    t.string   "street",         limit: 255
    t.string   "business_kind",  limit: 255
    t.string   "realty_kind",    limit: 255
    t.integer  "rooms"
    t.integer  "bathrooms"
    t.integer  "parking_spaces"
    t.integer  "size"
    t.integer  "price"
    t.integer  "taxes"
    t.text     "description"
    t.string   "status",         limit: 255
    t.integer  "account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",           limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  add_index "users", ["username", "account_id"], name: "index_users_on_username_and_account_id", unique: true, using: :btree

  add_foreign_key "cities", "countries"
  add_foreign_key "domains", "accounts"
  add_foreign_key "photos", "realties"
  add_foreign_key "realties", "accounts"
  add_foreign_key "realties", "cities"
  add_foreign_key "realties", "countries"
  add_foreign_key "users", "accounts"
end
