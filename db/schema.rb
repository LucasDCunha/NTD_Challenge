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

ActiveRecord::Schema[7.2].define(version: 2025_12_29_200945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.integer "category"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_logs", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.bigint "user_id", null: false
    t.integer "channel", null: false
    t.integer "status", default: 0, null: false
    t.datetime "delivered_at"
    t.text "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel", "status"], name: "index_notification_logs_on_channel_and_status"
    t.index ["created_at"], name: "index_notification_logs_on_created_at"
    t.index ["message_id", "created_at"], name: "index_notification_logs_on_message_id_and_created_at"
    t.index ["message_id"], name: "index_notification_logs_on_message_id"
    t.index ["user_id", "created_at"], name: "index_notification_logs_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_notification_logs_on_user_id"
  end

  create_table "user_category_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_category_subscriptions_on_user_id"
  end

  create_table "user_channel_preferences", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "channel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_channel_preferences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "notification_logs", "messages"
  add_foreign_key "notification_logs", "users"
  add_foreign_key "user_category_subscriptions", "users"
  add_foreign_key "user_channel_preferences", "users"
end
