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

ActiveRecord::Schema.define(version: 20160709160620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "email_confirmation_at"
    t.string "email_confirmation_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["email_confirmation_at"], name: "index_accounts_on_email_confirmation_at"
    t.index ["email_confirmation_token"], name: "index_accounts_on_email_confirmation_token", unique: true
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "theme"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_contacts_on_email"
  end

  create_table "feed_items", id: :serial, force: :cascade do |t|
    t.integer "feed_id"
    t.datetime "date"
    t.string "url"
    t.string "theme"
    t.text "text"
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checksum"], name: "index_feed_items_on_checksum"
    t.index ["created_at"], name: "index_feed_items_on_created_at"
    t.index ["feed_id"], name: "index_feed_items_on_feed_id"
  end

  create_table "feeds", id: :serial, force: :cascade do |t|
    t.string "url"
    t.datetime "last_fetch_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_fetch_at"], name: "index_feeds_on_last_fetch_at"
    t.index ["url"], name: "index_feeds_on_url", unique: true
  end

  create_table "forums", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "url"
    t.integer "target"
    t.integer "position"
    t.datetime "last_post_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_post_at"], name: "index_forums_on_last_post_at"
    t.index ["target"], name: "index_forums_on_target"
    t.index ["url"], name: "index_forums_on_url"
    t.index ["user_id"], name: "index_forums_on_user_id"
  end

  create_table "letter_items", id: :serial, force: :cascade do |t|
    t.integer "letter_id"
    t.string "name"
    t.string "url"
    t.datetime "last_post_at"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_post_at"], name: "index_letter_items_on_last_post_at"
    t.index ["letter_id"], name: "index_letter_items_on_letter_id"
    t.index ["url"], name: "index_letter_items_on_url"
  end

  create_table "letters", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.boolean "d1"
    t.boolean "d2"
    t.boolean "d3"
    t.boolean "d4"
    t.boolean "d5"
    t.boolean "d6"
    t.boolean "d7"
    t.integer "hour"
    t.integer "minute"
    t.datetime "last_post_at"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["d1"], name: "index_letters_on_d1"
    t.index ["d2"], name: "index_letters_on_d2"
    t.index ["d3"], name: "index_letters_on_d3"
    t.index ["d4"], name: "index_letters_on_d4"
    t.index ["d5"], name: "index_letters_on_d5"
    t.index ["d6"], name: "index_letters_on_d6"
    t.index ["d7"], name: "index_letters_on_d7"
    t.index ["hour"], name: "index_letters_on_hour"
    t.index ["last_post_at"], name: "index_letters_on_last_post_at"
    t.index ["minute"], name: "index_letters_on_minute"
    t.index ["user_id"], name: "index_letters_on_user_id"
  end

  create_table "mailer_sets", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "secret_name", null: false
    t.integer "status"
    t.datetime "last_post_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_post_at"], name: "index_mailer_sets_on_last_post_at"
    t.index ["secret_name"], name: "index_mailer_sets_on_secret_name", unique: true
    t.index ["status"], name: "index_mailer_sets_on_status"
    t.index ["user_id"], name: "index_mailer_sets_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "from"
    t.string "subject"
    t.text "body"
    t.text "attachments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reader_sets", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_reader_sets_on_status"
    t.index ["user_id"], name: "index_reader_sets_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.string "nick"
    t.string "jabber"
    t.datetime "jabber_confirmation_at"
    t.string "jabber_confirmation_token"
    t.string "lang"
    t.string "country"
    t.string "timezone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["country"], name: "index_users_on_country"
    t.index ["jabber"], name: "index_users_on_jabber", unique: true
    t.index ["jabber_confirmation_at"], name: "index_users_on_jabber_confirmation_at"
    t.index ["jabber_confirmation_token"], name: "index_users_on_jabber_confirmation_token", unique: true
    t.index ["lang"], name: "index_users_on_lang"
    t.index ["nick"], name: "index_users_on_nick", unique: true
    t.index ["timezone"], name: "index_users_on_timezone"
  end

  add_foreign_key "feed_items", "feeds"
  add_foreign_key "forums", "users"
  add_foreign_key "letter_items", "letters"
  add_foreign_key "letters", "users"
  add_foreign_key "mailer_sets", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "reader_sets", "users"
  add_foreign_key "users", "accounts"
end
