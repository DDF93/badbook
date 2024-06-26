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

ActiveRecord::Schema[7.1].define(version: 2024_03_28_213352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agendas", force: :cascade do |t|
    t.text "content"
    t.bigint "session_id", null: false
    t.bigint "user_id", null: false
    t.integer "upvotes"
    t.integer "downvotes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_agendas_on_session_id"
    t.index ["user_id"], name: "index_agendas_on_user_id"
  end

  create_table "attendees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "host"
    t.index ["session_id"], name: "index_attendees_on_session_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "genre"
    t.text "description"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.text "google_id"
  end

  create_table "bookshelf_books", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "bookshelf_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_bookshelf_books_on_book_id"
    t.index ["bookshelf_id"], name: "index_bookshelf_books_on_bookshelf_id"
  end

  create_table "bookshelves", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookshelves_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "session_id", null: false
    t.index ["session_id"], name: "index_chatrooms_on_session_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "user_id", null: false
    t.integer "capacity"
    t.datetime "start_time"
    t.string "video_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_time"
    t.string "host_url"
    t.string "room_url"
    t.index ["book_id"], name: "index_sessions_on_book_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.integer "votes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_topics_on_session_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "nickname"
    t.boolean "host", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "agendas", "sessions"
  add_foreign_key "agendas", "users"
  add_foreign_key "attendees", "sessions"
  add_foreign_key "attendees", "users"
  add_foreign_key "bookshelf_books", "books"
  add_foreign_key "bookshelf_books", "bookshelves"
  add_foreign_key "bookshelves", "users"
  add_foreign_key "chatrooms", "sessions"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "sessions", "books"
  add_foreign_key "sessions", "users"
  add_foreign_key "topics", "sessions"
  add_foreign_key "topics", "users"
end
