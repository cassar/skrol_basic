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

ActiveRecord::Schema.define(version: 20170202000937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string  "entry"
    t.integer "script_id"
  end

  create_table "lang_maps", force: :cascade do |t|
    t.integer "base_lang"
    t.integer "target_lang"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
  end

  create_table "ranks", force: :cascade do |t|
    t.integer "entriable_id"
    t.string  "entriable_type"
    t.integer "lang_map_id"
    t.integer "entry"
    t.index ["entriable_type", "entriable_id"], name: "index_ranks_on_entriable_type_and_entriable_id", using: :btree
  end

  create_table "regexes", force: :cascade do |t|
    t.string  "entry"
    t.integer "script_id"
  end

  create_table "rep_sents", force: :cascade do |t|
    t.integer "word_id"
    t.integer "rep_sent_id"
    t.integer "sentence_rank"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "entriable_id"
    t.string  "entriable_type"
    t.integer "map_to_id"
    t.string  "map_to_type"
    t.string  "name"
    t.float   "entry"
    t.index ["entriable_type", "entriable_id"], name: "index_scores_on_entriable_type_and_entriable_id", using: :btree
  end

  create_table "scripts", force: :cascade do |t|
    t.string  "name"
    t.string  "lang_code"
    t.integer "language_id"
    t.integer "parent_script_id"
  end

  create_table "sentences", force: :cascade do |t|
    t.string  "entry"
    t.integer "script_id"
    t.integer "group_id"
  end

  create_table "user_maps", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "word_rank"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "lang_map_id"
  end

  create_table "user_metrics", force: :cascade do |t|
    t.integer  "user_map_id"
    t.integer  "target_word_id"
    t.integer  "target_sentence_id"
    t.integer  "speed"
    t.boolean  "pause"
    t.boolean  "hover"
    t.boolean  "hide"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "user_scores", force: :cascade do |t|
    t.integer  "user_map_id"
    t.integer  "target_word_id"
    t.float    "entry"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "sentence_rank"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "words", force: :cascade do |t|
    t.string  "entry"
    t.integer "script_id"
    t.integer "group_id"
    t.integer "assoc_id"
  end

end
