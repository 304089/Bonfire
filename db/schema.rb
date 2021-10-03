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

ActiveRecord::Schema.define(version: 2021_10_03_085643) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "photo_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_post_id"], name: "index_bookmarks_on_photo_post_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "consultation_answers", force: :cascade do |t|
    t.integer "consultation_id", null: false
    t.integer "user_id", null: false
    t.text "answer", null: false
    t.string "answer_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_id"], name: "index_consultation_answers_on_consultation_id"
    t.index ["user_id"], name: "index_consultation_answers_on_user_id"
  end

  create_table "consultation_genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "consultation_genre_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.string "consultation_image_id"
    t.boolean "anonymity", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_genre_id"], name: "index_consultations_on_consultation_genre_id"
    t.index ["user_id"], name: "index_consultations_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "photo_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_post_id"], name: "index_favorites_on_photo_post_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "helpfulnesses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "consultation_answer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_answer_id"], name: "index_helpfulnesses_on_consultation_answer_id"
    t.index ["user_id"], name: "index_helpfulnesses_on_user_id"
  end

  create_table "infomations", force: :cascade do |t|
    t.string "email", null: false
    t.string "genre", default: "0", null: false
    t.text "content", null: false
    t.string "status", default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photo_post_comments", force: :cascade do |t|
    t.integer "photo_post_id", null: false
    t.integer "user_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_post_id"], name: "index_photo_post_comments_on_photo_post_id"
    t.index ["user_id"], name: "index_photo_post_comments_on_user_id"
  end

  create_table "photo_post_genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photo_posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "photo_post_genre_id", null: false
    t.text "introduction", null: false
    t.string "photo_image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_post_genre_id"], name: "index_photo_posts_on_photo_post_genre_id"
    t.index ["user_id"], name: "index_photo_posts_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.text "introduction"
    t.string "profile_image_id"
    t.boolean "admin", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
