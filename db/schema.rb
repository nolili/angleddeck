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

ActiveRecord::Schema.define(version: 20160110155143) do

  create_table "builds", force: :cascade do |t|
    t.integer  "topic_id",          null: false
    t.string   "bundle_identifier", null: false
    t.string   "bundle_version",    null: false
    t.string   "url",               null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "projects", id: false, force: :cascade do |t|
    t.string   "guid",       null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid"], name: "index_projects_on_guid", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string   "project_guid", null: false
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["project_guid", "url"], name: "index_topics_on_project_guid_and_url"
  end

end
