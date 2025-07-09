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

ActiveRecord::Schema[7.1].define(version: 2025_07_08_055217) do
  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "children", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.date "birthday", null: false
    t.integer "gender", null: false
    t.text "allergy_info"
    t.string "blood_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "height_weights", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.date "recorded_on", null: false
    t.float "height"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_height_weights_on_child_id"
  end

  create_table "record_tags", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "record_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_record_tags_on_record_id"
    t.index ["tag_id"], name: "index_record_tags_on_tag_id"
  end

  create_table "records", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_records_on_child_id"
  end

  create_table "shared_users", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shared_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shared_user_id"], name: "index_shared_users_on_shared_user_id"
    t.index ["user_id", "shared_user_id"], name: "index_shared_users_on_user_id_and_shared_user_id", unique: true
    t.index ["user_id"], name: "index_shared_users_on_user_id"
  end

  create_table "tags", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vaccination_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.integer "vaccine_id"
    t.string "other_vaccine_name"
    t.string "hospital_name"
    t.text "memo"
    t.date "scheduled_date"
    t.boolean "completed", default: false
    t.date "vaccinated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_vaccination_records_on_child_id"
  end

  create_table "vaccines", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "min_month"
    t.integer "max_month"
    t.boolean "optional"
    t.json "dose_months"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recommended_doses"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "children", "users"
  add_foreign_key "height_weights", "children"
  add_foreign_key "record_tags", "records"
  add_foreign_key "record_tags", "tags"
  add_foreign_key "records", "children"
  add_foreign_key "shared_users", "shared_users"
  add_foreign_key "shared_users", "users"
  add_foreign_key "vaccination_records", "children"
end
