# sample-app

何か開発を行う際の雛型となるアプリ。

- 開発環境: Docker
- 言語: Ruby 2.6
- フレームワーク: Rails 6
- データベース: MySQL 5.7
- アプリケーションサーバー: Puma
- Webサーバー: Nginx

## セットアップ

```
$ docker-compose build
$ docker-compose up -d
$ docker-compose run web rails webpacker:install
$ docker-compose run web rails db:create
```
