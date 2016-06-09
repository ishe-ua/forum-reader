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

ActiveRecord::Schema.define(version: 20160420090853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email",                    null: false
    t.string   "password_digest",          null: false
    t.datetime "email_confirmation_at"
    t.string   "email_confirmation_token"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["email_confirmation_at"], name: "index_accounts_on_email_confirmation_at", using: :btree
  add_index "accounts", ["email_confirmation_token"], name: "index_accounts_on_email_confirmation_token", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "theme"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacts", ["email"], name: "index_contacts_on_email", using: :btree

  create_table "feed_items", force: :cascade do |t|
    t.integer  "feed_id"
    t.datetime "date"
    t.string   "url"
    t.string   "theme"
    t.text     "text"
    t.string   "checksum",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feed_items", ["checksum"], name: "index_feed_items_on_checksum", using: :btree
  add_index "feed_items", ["created_at"], name: "index_feed_items_on_created_at", using: :btree
  add_index "feed_items", ["feed_id"], name: "index_feed_items_on_feed_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.string   "url"
    t.datetime "last_fetch_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "feeds", ["last_fetch_at"], name: "index_feeds_on_last_fetch_at", using: :btree
  add_index "feeds", ["url"], name: "index_feeds_on_url", unique: true, using: :btree

  create_table "forums", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.integer  "target"
    t.integer  "position"
    t.datetime "last_post_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "forums", ["last_post_at"], name: "index_forums_on_last_post_at", using: :btree
  add_index "forums", ["target"], name: "index_forums_on_target", using: :btree
  add_index "forums", ["url"], name: "index_forums_on_url", using: :btree
  add_index "forums", ["user_id"], name: "index_forums_on_user_id", using: :btree

  create_table "letter_items", force: :cascade do |t|
    t.integer  "letter_id"
    t.string   "name"
    t.string   "url"
    t.datetime "last_post_at"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "letter_items", ["last_post_at"], name: "index_letter_items_on_last_post_at", using: :btree
  add_index "letter_items", ["letter_id"], name: "index_letter_items_on_letter_id", using: :btree
  add_index "letter_items", ["url"], name: "index_letter_items_on_url", using: :btree

  create_table "letters", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "d1"
    t.boolean  "d2"
    t.boolean  "d3"
    t.boolean  "d4"
    t.boolean  "d5"
    t.boolean  "d6"
    t.boolean  "d7"
    t.integer  "hour"
    t.integer  "minute"
    t.datetime "last_post_at"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "letters", ["d1"], name: "index_letters_on_d1", using: :btree
  add_index "letters", ["d2"], name: "index_letters_on_d2", using: :btree
  add_index "letters", ["d3"], name: "index_letters_on_d3", using: :btree
  add_index "letters", ["d4"], name: "index_letters_on_d4", using: :btree
  add_index "letters", ["d5"], name: "index_letters_on_d5", using: :btree
  add_index "letters", ["d6"], name: "index_letters_on_d6", using: :btree
  add_index "letters", ["d7"], name: "index_letters_on_d7", using: :btree
  add_index "letters", ["hour"], name: "index_letters_on_hour", using: :btree
  add_index "letters", ["last_post_at"], name: "index_letters_on_last_post_at", using: :btree
  add_index "letters", ["minute"], name: "index_letters_on_minute", using: :btree
  add_index "letters", ["user_id"], name: "index_letters_on_user_id", using: :btree

  create_table "mailer_sets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mailer_sets", ["status"], name: "index_mailer_sets_on_status", using: :btree
  add_index "mailer_sets", ["user_id"], name: "index_mailer_sets_on_user_id", using: :btree

  create_table "reader_sets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reader_sets", ["status"], name: "index_reader_sets_on_status", using: :btree
  add_index "reader_sets", ["user_id"], name: "index_reader_sets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "nick"
    t.string   "jabber"
    t.datetime "jabber_confirmation_at"
    t.string   "jabber_confirmation_token"
    t.string   "lang"
    t.string   "country"
    t.string   "timezone"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["country"], name: "index_users_on_country", using: :btree
  add_index "users", ["jabber"], name: "index_users_on_jabber", unique: true, using: :btree
  add_index "users", ["jabber_confirmation_at"], name: "index_users_on_jabber_confirmation_at", using: :btree
  add_index "users", ["jabber_confirmation_token"], name: "index_users_on_jabber_confirmation_token", unique: true, using: :btree
  add_index "users", ["lang"], name: "index_users_on_lang", using: :btree
  add_index "users", ["nick"], name: "index_users_on_nick", unique: true, using: :btree
  add_index "users", ["timezone"], name: "index_users_on_timezone", using: :btree

  add_foreign_key "feed_items", "feeds"
  add_foreign_key "forums", "users"
  add_foreign_key "letter_items", "letters"
  add_foreign_key "letters", "users"
  add_foreign_key "mailer_sets", "users"
  add_foreign_key "reader_sets", "users"
  add_foreign_key "users", "accounts"
end
