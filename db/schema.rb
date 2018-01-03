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

ActiveRecord::Schema.define(version: 20171230050754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.integer  "language_map_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "enrolments", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "course_id"
  end

  create_table "language_maps", force: :cascade do |t|
    t.integer "base_language_id"
    t.integer "target_language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
  end

  create_table "meta_data", force: :cascade do |t|
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.text     "entry"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "source"
    t.index ["contentable_type", "contentable_id"], name: "index_meta_data_on_contentable_type_and_contentable_id", using: :btree
  end

  create_table "scripts", force: :cascade do |t|
    t.string  "name"
    t.integer "language_id"
    t.integer "standard_id"
  end

  create_table "sentence_associates", force: :cascade do |t|
    t.integer "associate_a_id"
    t.integer "associate_b_id"
    t.text    "representations"
    t.index ["associate_a_id", "associate_b_id"], name: "index_sentence_associates_on_associate_a_id_and_associate_b_id", unique: true, using: :btree
  end

  create_table "sentence_scores", force: :cascade do |t|
    t.integer "course_id"
    t.integer "sentence_id"
    t.float   "entry"
  end

  create_table "sentences", force: :cascade do |t|
    t.string  "entry"
    t.integer "script_id"
  end

  create_table "sentences_words", id: false, force: :cascade do |t|
    t.integer "word_id",     null: false
    t.integer "sentence_id", null: false
    t.index ["sentence_id"], name: "index_sentences_words_on_sentence_id", using: :btree
    t.index ["word_id"], name: "index_sentences_words_on_word_id", using: :btree
  end

  create_table "user_metrics", force: :cascade do |t|
    t.integer  "user_score_id"
    t.integer  "sentence_id"
    t.integer  "speed"
    t.boolean  "pause"
    t.boolean  "hover"
    t.boolean  "hide"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_scores", force: :cascade do |t|
    t.integer  "enrolment_id"
    t.integer  "word_id"
    t.float    "entry"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "current_speed"
    t.boolean  "base_hidden"
    t.boolean  "paused"
  end

  create_table "word_associates", force: :cascade do |t|
    t.integer "associate_a_id"
    t.integer "associate_b_id"
    t.index ["associate_a_id", "associate_b_id"], name: "index_word_associates_on_associate_a_id_and_associate_b_id", unique: true, using: :btree
  end

  create_table "word_phonetics", force: :cascade do |t|
    t.integer "standard_id"
    t.integer "phonetic_id"
    t.index ["standard_id", "phonetic_id"], name: "index_word_phonetics_on_standard_id_and_phonetic_id", unique: true, using: :btree
  end

  create_table "word_scores", force: :cascade do |t|
    t.integer "word_id"
    t.integer "course_id"
    t.float   "entry"
    t.integer "rank"
  end

  create_table "words", force: :cascade do |t|
    t.string  "entry"
    t.integer "script_id"
  end

end
