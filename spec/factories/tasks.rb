FactoryBot.define do
  factory :task do
    task_name {'task'}
    content {'content'}
    end_on {'2020-05-11'}
    status {(I18n.t('view.wip'))}
    priority {'高'}
    user_id { 10 }
  end

  factory :new_task, class: Task do
    task_name {'new_task'}
    content {'new_content'}
    end_on {'2020-05-12'}
    status {(I18n.t('view.wip'))}
    priority {'高'}
    user_id { 20 }
  end
end
