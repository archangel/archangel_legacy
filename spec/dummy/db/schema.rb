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

ActiveRecord::Schema.define(version: 20171006204710) do

  create_table "archangel_assets", force: :cascade do |t|
    t.string "file_name"
    t.string "file"
    t.string "content_type"
    t.integer "file_size"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_assets_on_deleted_at"
    t.index ["file_name"], name: "index_archangel_assets_on_file_name", unique: true
  end

  create_table "archangel_collections", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_collections_on_deleted_at"
    t.index ["name"], name: "index_archangel_collections_on_name"
    t.index ["slug"], name: "index_archangel_collections_on_slug", unique: true
  end

  create_table "archangel_entries", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "field_id"
    t.text "value"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_archangel_entries_on_collection_id"
    t.index ["deleted_at"], name: "index_archangel_entries_on_deleted_at"
    t.index ["field_id"], name: "index_archangel_entries_on_field_id"
  end

  create_table "archangel_fields", force: :cascade do |t|
    t.integer "collection_id"
    t.string "label"
    t.string "slug"
    t.string "classification"
    t.boolean "required"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classification"], name: "index_archangel_fields_on_classification"
    t.index ["collection_id"], name: "index_archangel_fields_on_collection_id"
    t.index ["deleted_at"], name: "index_archangel_fields_on_deleted_at"
    t.index ["label"], name: "index_archangel_fields_on_label"
    t.index ["required"], name: "index_archangel_fields_on_required"
    t.index ["slug"], name: "index_archangel_fields_on_slug"
  end

  create_table "archangel_pages", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "template_id"
    t.string "title"
    t.string "slug"
    t.string "path"
    t.text "content", default: ""
    t.boolean "homepage", default: false
    t.string "meta_keywords"
    t.string "meta_description"
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_pages_on_deleted_at"
    t.index ["homepage"], name: "index_archangel_pages_on_homepage"
    t.index ["parent_id"], name: "index_archangel_pages_on_parent_id"
    t.index ["path"], name: "index_archangel_pages_on_path", unique: true
    t.index ["published_at"], name: "index_archangel_pages_on_published_at"
    t.index ["slug"], name: "index_archangel_pages_on_slug"
    t.index ["template_id"], name: "index_archangel_pages_on_template_id"
    t.index ["title"], name: "index_archangel_pages_on_title"
  end

  create_table "archangel_sites", force: :cascade do |t|
    t.string "name", default: "Archangel", null: false
    t.string "theme"
    t.string "locale", default: "en", null: false
    t.string "logo"
    t.string "favicon"
    t.string "meta_keywords"
    t.string "meta_description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_sites_on_deleted_at"
    t.index ["name"], name: "index_archangel_sites_on_name"
  end

  create_table "archangel_templates", force: :cascade do |t|
    t.integer "parent_id"
    t.string "name"
    t.text "content", default: ""
    t.boolean "partial"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_templates_on_deleted_at"
    t.index ["parent_id"], name: "index_archangel_templates_on_parent_id"
  end

  create_table "archangel_users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "username", default: "", null: false
    t.string "role"
    t.string "avatar"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_archangel_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_archangel_users_on_deleted_at"
    t.index ["email"], name: "index_archangel_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_archangel_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_archangel_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_archangel_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_archangel_users_on_invited_by_type_and_invited_by_id"
    t.index ["name"], name: "index_archangel_users_on_name"
    t.index ["reset_password_token"], name: "index_archangel_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_archangel_users_on_role"
    t.index ["unlock_token"], name: "index_archangel_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_archangel_users_on_username", unique: true
  end

  create_table "archangel_widgets", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "content"
    t.integer "template_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_archangel_widgets_on_deleted_at"
    t.index ["name"], name: "index_archangel_widgets_on_name"
    t.index ["slug"], name: "index_archangel_widgets_on_slug", unique: true
    t.index ["template_id"], name: "index_archangel_widgets_on_template_id"
  end

end
