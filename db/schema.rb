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

ActiveRecord::Schema.define(version: 20160511101558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string   "iso3",       limit: 3
    t.text     "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "countries", ["iso3"], name: "index_countries_on_iso3", unique: true, using: :btree

  create_table "countries_protected_areas", force: :cascade do |t|
    t.integer  "protected_area_id"
    t.integer  "country_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "countries_protected_areas", ["country_id", "protected_area_id"], name: "index_cpas_on_country_id_and_protected_area_id", unique: true, using: :btree

  create_table "designation_types", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "designations", force: :cascade do |t|
    t.text     "name"
    t.integer  "designation_type_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "designations", ["designation_type_id"], name: "index_designations_on_designation_type_id", using: :btree

  create_table "protected_areas", force: :cascade do |t|
    t.text     "name"
    t.integer  "wdpa_id"
    t.text     "status"
    t.integer  "designation_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "protected_areas", ["designation_id"], name: "index_protected_areas_on_designation_id", using: :btree
  add_index "protected_areas", ["status"], name: "index_protected_areas_on_status", using: :btree
  add_index "protected_areas", ["wdpa_id"], name: "index_protected_areas_on_wdpa_id", using: :btree

  create_table "protected_areas_wdpa_releases", force: :cascade do |t|
    t.integer  "protected_area_id"
    t.integer  "wdpa_release_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "protected_areas_wdpa_releases", ["protected_area_id"], name: "index_protected_areas_wdpa_releases_on_protected_area_id", using: :btree
  add_index "protected_areas_wdpa_releases", ["wdpa_release_id"], name: "index_protected_areas_wdpa_releases_on_wdpa_release_id", using: :btree

  create_table "wdpa_releases", force: :cascade do |t|
    t.text     "name"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "countries_protected_areas", "countries"
  add_foreign_key "countries_protected_areas", "protected_areas"
  add_foreign_key "designations", "designation_types"
  add_foreign_key "protected_areas", "designations"
  add_foreign_key "protected_areas_wdpa_releases", "protected_areas"
  add_foreign_key "protected_areas_wdpa_releases", "wdpa_releases"
end
