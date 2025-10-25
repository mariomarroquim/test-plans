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

ActiveRecord::Schema[8.0].define(version: 2025_10_24_194413) do
  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "test_plans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "feature", null: false
    t.string "use_case", null: false
    t.text "steps_to_reproduce", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature", "use_case"], name: "index_test_plans_feature_use_case", unique: true
    t.index ["user_id"], name: "index_test_plans_on_user_id"
  end

  create_table "test_runs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "test_plan_id", null: false
    t.string "revision", null: false
    t.boolean "passed", null: false
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_plan_id"], name: "index_test_runs_on_test_plan_id"
    t.index ["user_id"], name: "index_test_runs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.date "paid_at"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "whodunnit"
    t.datetime "created_at"
    t.bigint "item_id", null: false
    t.string "item_type", null: false
    t.string "event", null: false
    t.text "object", limit: 1073741823
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "sessions", "users"
  add_foreign_key "test_plans", "users"
  add_foreign_key "test_runs", "test_plans"
  add_foreign_key "test_runs", "users"
end
