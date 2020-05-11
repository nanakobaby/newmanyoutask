class ChangeNotnullToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :task_name, :string, null: false
    change_column :tasks, :content, :text, null: false
  end
end
