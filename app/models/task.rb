class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true
  scope :task_name_like, -> task_name { where('task_name LIKE ?', "%#{task_name}%") }
  scope :status, -> status { where(status: status) }
  enum priority:{ 高: 0, 中: 1, 低: 2 }
end
