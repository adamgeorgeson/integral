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

ActiveRecord::Schema.define(version: 20171030215202) do

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "integral_images", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "file"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "deleted_at"
    t.boolean  "file_processing", default: true, null: false
    t.integer  "file_size"
  end

  add_index "integral_images", ["deleted_at"], name: "index_integral_images_on_deleted_at"

  create_table "integral_list_item_connections", id: false, force: :cascade do |t|
    t.integer "parent_id", null: false
    t.integer "child_id",  null: false
  end

  create_table "integral_list_items", force: :cascade do |t|
    t.integer  "list_id"
    t.string   "title"
    t.text     "description"
    t.string   "subtitle"
    t.string   "url"
    t.integer  "image_id"
    t.string   "target"
    t.string   "html_classes"
    t.integer  "priority"
    t.integer  "object_id"
    t.string   "type"
    t.string   "object_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integral_list_versions", force: :cascade do |t|
    t.string   "item_type",                         null: false
    t.integer  "item_id",                           null: false
    t.string   "event",                             null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 1073741823
    t.text     "object_changes", limit: 1073741823
    t.datetime "created_at"
  end

  add_index "integral_list_versions", ["item_type", "item_id"], name: "index_integral_list_versions_on_item_type_and_item_id"

  create_table "integral_lists", force: :cascade do |t|
    t.string   "title",        null: false
    t.text     "description"
    t.boolean  "locked"
    t.string   "html_classes"
    t.string   "html_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integral_page_versions", force: :cascade do |t|
    t.string   "item_type",                         null: false
    t.integer  "item_id",                           null: false
    t.string   "event",                             null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 1073741823
    t.text     "object_changes", limit: 1073741823
    t.datetime "created_at"
  end

  add_index "integral_page_versions", ["item_type", "item_id"], name: "index_integral_page_versions_on_item_type_and_item_id"

  create_table "integral_pages", force: :cascade do |t|
    t.string   "title"
    t.string   "path"
    t.text     "description"
    t.text     "body"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "status",      default: 0
    t.datetime "deleted_at"
    t.string   "template",    default: "default"
    t.integer  "parent_id"
  end

  add_index "integral_pages", ["deleted_at"], name: "index_integral_pages_on_deleted_at"

  create_table "integral_post_versions", force: :cascade do |t|
    t.string   "item_type",                         null: false
    t.integer  "item_id",                           null: false
    t.string   "event",                             null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 1073741823
    t.text     "object_changes", limit: 1073741823
    t.datetime "created_at"
  end

  add_index "integral_post_versions", ["item_type", "item_id"], name: "index_integral_post_versions_on_item_type_and_item_id"

  create_table "integral_post_viewings", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "integral_post_viewings", ["post_id"], name: "index_integral_post_viewings_on_post_id"

  create_table "integral_posts", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "slug"
    t.integer  "view_count",   default: 0
    t.datetime "published_at"
    t.integer  "status",       default: 0
    t.datetime "deleted_at"
    t.integer  "image_id"
  end

  add_index "integral_posts", ["deleted_at"], name: "index_integral_posts_on_deleted_at"
  add_index "integral_posts", ["image_id"], name: "index_integral_posts_on_image_id"
  add_index "integral_posts", ["slug"], name: "index_integral_posts_on_slug", unique: true
  add_index "integral_posts", ["user_id"], name: "index_integral_posts_on_user_id"

  create_table "integral_role_assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "integral_role_assignments", ["role_id"], name: "index_integral_role_assignments_on_role_id"
  add_index "integral_role_assignments", ["user_id"], name: "index_integral_role_assignments_on_user_id"

  create_table "integral_roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "integral_user_versions", force: :cascade do |t|
    t.string   "item_type",                         null: false
    t.integer  "item_id",                           null: false
    t.string   "event",                             null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 1073741823
    t.text     "object_changes", limit: 1073741823
    t.datetime "created_at"
  end

  add_index "integral_user_versions", ["item_type", "item_id"], name: "index_integral_user_versions_on_item_type_and_item_id"

  create_table "integral_users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "avatar"
    t.string   "locale",                 default: "en", null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.datetime "deleted_at"
    t.boolean  "avatar_processing",      default: true, null: false
  end

  add_index "integral_users", ["deleted_at"], name: "index_integral_users_on_deleted_at"
  add_index "integral_users", ["email"], name: "index_integral_users_on_email", unique: true
  add_index "integral_users", ["invitation_token"], name: "index_integral_users_on_invitation_token", unique: true
  add_index "integral_users", ["invitations_count"], name: "index_integral_users_on_invitations_count"
  add_index "integral_users", ["invited_by_id"], name: "index_integral_users_on_invited_by_id"
  add_index "integral_users", ["reset_password_token"], name: "index_integral_users_on_reset_password_token", unique: true

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
