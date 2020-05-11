ActiveRecord::Schema.define(version: 2020_05_10_225605) do

enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "task_name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
