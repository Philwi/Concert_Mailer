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

ActiveRecord::Schema.define(version: 2018_08_11_094625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bands", force: :cascade do |t|
    t.string "name"
    t.string "ort"
    t.string "bandcamp"
    t.string "website"
    t.date "gründung"
    t.string "email"
    t.string "telefon"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_color"
    t.index ["user_id"], name: "index_bands_on_user_id"
  end

  create_table "bookers", force: :cascade do |t|
    t.string "stadt"
    t.string "club"
    t.string "name"
    t.string "homepage"
    t.string "email"
    t.string "telefon"
    t.string "bundesland"
    t.string "land"
    t.string "plz"
    t.datetime "created_at", default: "2018-08-06 19:13:29", null: false
    t.datetime "updated_at", default: "2018-08-06 19:13:29", null: false
    t.float "lat"
    t.float "lng"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "location"
    t.string "link"
    t.text "bands"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "band_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_events_on_band_id"
  end

  create_table "mailings", force: :cascade do |t|
    t.string "subject"
    t.text "body"
    t.integer "veranstalter", array: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mailings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "telefon"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
