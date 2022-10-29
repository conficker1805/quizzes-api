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

ActiveRecord::Schema[7.0].define(version: 2022_10_29_102441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.string "active", default: "active", null: false
    t.boolean "correct", default: false, null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_answers_on_active"
    t.index ["quiz_id"], name: "index_answers_on_quiz_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "domain_id", null: false
    t.hstore "expectation", default: {}, null: false
    t.hstore "answers", default: {}, null: false
    t.string "state", default: "processing", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_assessments_on_domain_id"
    t.index ["state"], name: "index_assessments_on_state"
    t.index ["user_id"], name: "index_assessments_on_user_id"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_domains_on_slug"
  end

  create_table "quizzes", force: :cascade do |t|
    t.bigint "domain_id", null: false
    t.string "kind", null: false
    t.string "state", default: "active", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_quizzes_on_domain_id"
    t.index ["kind"], name: "index_quizzes_on_kind"
    t.index ["state"], name: "index_quizzes_on_state"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
