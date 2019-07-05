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

ActiveRecord::Schema.define(version: 2019_07_04_081922) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.text "url"
    t.integer "interval_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_fetched_at"
    t.boolean "should_fetch", default: true
    t.boolean "should_show", default: true
  end

  create_table "items", force: :cascade do |t|
    t.text "link"
    t.text "description"
    t.datetime "pub_date"
    t.text "title"
    t.text "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "feed_id"
    t.index ["feed_id"], name: "index_items_on_feed_id"
  end

end
