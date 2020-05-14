require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  it 'task_nameが空ならバリデーションが通らない' do
    task = Task.new(task_name: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = FactoryBot.build(:task, task_name: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it 'task_nameとcontentに内容が記載されていればバリデーションが通る' do
    task = FactoryBot.build(:new_task, task_name: '', content: '')
    expect(task).not_to be_valid
    expect(task.errors[:task_name]).to be_present
  end
end
