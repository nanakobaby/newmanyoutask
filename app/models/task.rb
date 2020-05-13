class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true
  scope :task_name_like, -> task_name { where('task_name LIKE ?', "%#{task_name}%") }
end
