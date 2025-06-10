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

ActiveRecord::Schema[7.2].define(version: 2025_06_10_061922) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "technique_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["technique_id"], name: "index_favorites_on_technique_id"
    t.index ["user_id", "technique_id"], name: "index_favorites_on_user_id_and_technique_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_follows_on_category_id"
    t.index ["user_id", "category_id"], name: "index_follows_on_user_id_and_category_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "technique_categories", force: :cascade do |t|
    t.bigint "technique_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_technique_categories_on_category_id"
    t.index ["technique_id"], name: "index_technique_categories_on_technique_id"
  end

  create_table "techniques", force: :cascade do |t|
    t.string "title", null: false
    t.integer "source_type", null: false
    t.string "source_url", null: false
    t.string "video_timestamp"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_techniques_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorites", "techniques"
  add_foreign_key "favorites", "users"
  add_foreign_key "folders", "users"
  add_foreign_key "follows", "categories"
  add_foreign_key "follows", "users"
  add_foreign_key "technique_categories", "categories"
  add_foreign_key "technique_categories", "techniques"
  add_foreign_key "techniques", "users"
end
