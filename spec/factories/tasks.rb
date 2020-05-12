FactoryBot.define do
  factory :task do
    task_name {'task'}
    content {'content'}
    end_on {'2020-05-11'}
  end

  factory :new_task, class: Task do
    task_name {'new_task'}
    content {'new_content'}
    end_on {'2020-05-12'}
  end
end
