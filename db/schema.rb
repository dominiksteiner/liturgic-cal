# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_03_180933) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendar_days", force: :cascade do |t|
    t.integer "day"
    t.integer "month"
    t.integer "year"
    t.bigint "liturgic_day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liturgic_day_id"], name: "index_calendar_days_on_liturgic_day_id"
  end

  create_table "celebrations", force: :cascade do |t|
    t.string "title"
    t.string "colour"
    t.string "rank"
    t.string "rank_num"
    t.bigint "liturgic_day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liturgic_day_id"], name: "index_celebrations_on_liturgic_day_id"
  end

  create_table "liturgic_days", force: :cascade do |t|
    t.string "season"
    t.string "season_week"
    t.string "weekday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.string "external_id"
    t.string "title"
    t.string "description"
    t.datetime "published_at"
    t.string "thumbnail_url"
    t.string "url"
    t.bigint "liturgic_day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liturgic_day_id"], name: "index_media_on_liturgic_day_id"
  end

  add_foreign_key "calendar_days", "liturgic_days"
  add_foreign_key "celebrations", "liturgic_days"
  add_foreign_key "media", "liturgic_days"
end
