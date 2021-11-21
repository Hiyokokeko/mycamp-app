# MY CAMP（仮）

おすすめのキャンプ場やキャンプ道具を共有できる投稿サイトです。

### [リンク]：( https://realshinkitv.com )

※現在停止中。

_過去に作成したトップページ画像を再利用中_
https://github.com/Hiyokokeko/realcampgears.git
![トップページ](https://user-images.githubusercontent.com/62534064/142758379-f520c525-c685-4f70-b8c7-1a89097f86b4.jpg "トップ画像")

## 使用技術

### フロントエンド

- HTML/CSS
- Javascript
- Nuxt.js（SPA）
- Vuetify（UI フレームワーク）
- Jest（テストツール）
- ESLint/Prettier（コード解析ツール）

### バックエンド

- Ruby 2.7.2
- Rails 6.0.3 （API モード）
- Rubocop（コード解析ツール）
- RSpec（テスト）

### DB

- MySQL 5.7

### インフラ・開発環境等

- Docker/Docker-compose
- AWS（ECR, ECS, VPC, S3, Route53, ALB, RDS, SSM, ACM）
- Terraform（インフラをコード管理）
- CircleCI（CI/CD）

## AWS 構成図

![aws構成図](https://user-images.githubusercontent.com/62534064/142761057-c44a7f9a-f133-4e16-aed2-75207ecb7fc4.png)

## 機能一覧（予定）

### ユーザー機能

- 新規登録
- ログイン/ログアウト
- ユーザーマイページ（いいね・フォロー関連）
- ユーザー編集（登録情報変更）
- ユーザーフォロー機能

### 記事投稿機能

- 記事の編集/削除
- 画像投稿
- いいね・コメント

### 記事表示機能

- カテゴリー別表示
- 検索機能
- ソート機能
- いいね数によるランキング表示
- ページネーション
