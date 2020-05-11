# README

##Name

====

Task management

##Overview

Task managementは、タスク管理ができるツールで、Ruby on Railsで記述されています。

## Description

このツールを使うと、以下のことが可能になります。

- 自分のタスクを簡単に登録

- タスクに終了期限を設定

- タスクに優先順位をつける

- ステータス(未着手・着手・完了)を管理

- ステータスでタスクを絞り込む

- タスク名などで指定のタスクを検索

- タスク一覧で(優先順位、終了期限などを元にして)ソート

- テスクにラベルをつけて分類

- ユーザー登録し、自分が登録したタスクだけ見る

## table

**Userテーブル**

| Column   | Type    |
| -------- | ------- |
| name     | string  |
| email    | string  |
| password | string  |

**Taskテーブル**

| Column  | Type    | Description |
| ------- | ------- | ----------- |
| name    | string  |             |
| content | text    |             |
| user_id | index   | foreign_key |

**Labelテーブル**

| Column  | Type    | Description |
| ------- | ------- | ----------- |
| task_id | integer | foreign_key |
| user_id | integer | foreign_key |

#デプロイ方法

このアプリで使っているRubyフレームワークのバージョンは、

Ruby on Rails 5.2.4

```console
$ heroku login
```

 herokuにログインします。

```console
$ heroku create
```

 新しいリポジトリを作る。　自動でリモートリポジトリとして登録されます。

```console
$ git push heroku master
```

 herokuにpushします。

```console
$ heroku run rails db:migrate
```

 heroku上にデータベース作成。

アプリケーションにアクセスできれば成功です。Herokuアプリのアドレスは、https://アプリ名.herokuapp.com/ のように設定されます。
