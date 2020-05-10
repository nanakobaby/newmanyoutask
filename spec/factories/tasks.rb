FactoryBot.define do
  factory :task do
    task_name {'task'}
    content {'content'}
  end

  factory :new_task, class: Task do
    task_name {'new_task'}
    content {'new_content'}
  end
end
