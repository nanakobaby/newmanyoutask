require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task)
    @new_task = FactoryBot.create(:new_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit new_user_path
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit new_user_path
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
    end

    context 'scopeメソッドで検索をした場合' do
      before do
        @user = FactoryBot.create(:user)
        @task = FactoryBot.create(:task)
        @new_task = FactoryBot.create(:new_task)
      end
      it "scopeメソッドでタスク名検索ができる" do
        visit new_user_path
        #タスク一覧ページに飛ぶ
        visit tasks_path
        #タスクの検索欄に検索ワードを入力する(例: task)
        fill_in 'task_name', with: 'task'
        #検索ボタンを押す
        click_button (I18n.t('helpers.submit.search'))
        expect(page).to have_content 'task'
      end
      it "scopeメソッドでステータス検索ができる" do
        visit new_user_path
        visit tasks_path
        select (I18n.t('view.wip')), from: 'status'
        click_button (I18n.t('helpers.submit.search'))
        expect(page).to have_selector 'td',text: (I18n.t('view.wip'))
      end
      it "scopeメソッドでタスク名とステータスの両方が検索できる" do
        visit new_user_path
        visit tasks_path
        select (I18n.t('view.wip')), from: 'status'
        fill_in 'task_name', with: 'task'
        click_button (I18n.t('helpers.submit.search'))
        expect(page).to have_content 'task'
        expect(page).to have_selector 'td',text: (I18n.t('view.wip'))
      end
    end
  end

  describe '終了期限での並び替え' do
    context '終了期日を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_user_path
        visit new_task_path
        select '2020', from: 'task_end_on_1i'
        select '5', from: 'task_end_on_2i'
        select '11', from: 'task_end_on_3i'
        click_button (I18n.t('helpers.submit.create'))
        expect(page).to have_content '2020'
        expect(page).to have_content '5'
        expect(page).to have_content '11'
      end
    end

    context '終了期限でソートするリンクをクリックした場合' do
      it 'タスクが終了期限の降順に並んでいる' do
        visit new_user_path
        visit tasks_path
        click_link (I18n.t('view.sort_end_date'))
        task_list = all('.date_row')
        expect(task_list[0]).to have_content '2020-05-12'
        expect(task_list[1]).to have_content '2020-05-11'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_user_path
        visit new_task_path
        click_button (I18n.t('helpers.submit.create'))
        expect(page).to have_content 'task'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
         visit task_path(id: 1)
         expect(page).to have_content 'task'
       end
     end
  end
end
