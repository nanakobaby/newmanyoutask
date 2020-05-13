ActiveRecord::Schema.define(version: 2020_05_12_123712) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "task_name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "end_on"
    t.string "status"
  end

end
