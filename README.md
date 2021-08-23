
# アプリ名
## Mariasyu
（読み方：まりあーしゅ）
お酒と料理の相性の良さを表す「マリアージュ」と「お酒」を組み合わせて名付けました。

# 概要
おすすめのマリアージュを投稿・検索することができるアプリケーションです。

お酒の楽しみ方を知りたい方や、教えたい方が
「おつまみ何にしようかな？」「この料理に合うお酒は何かな？」
もしくは「このマリアージュを知ってもらいたいな」
と思ったタイミングで、気軽に使用することができます。

# 本番環境
### デプロイ先
- URL(仮) : https://mariasyu.herokuapp.com/
### Basic認証
- ID      : admin
- PASS    : 2222
### テスト用アカウント
- email   : hoge@hoge
- pass    : hoge1111

# 制作背景
私は日本酒が好きです。特に、料理との組み合わせ次第で全く違う味になるところが面白く感じています。
レシピやお酒を薦めるアプリケーションは多数存在していますが、組み合わせをすすめてくれるアプリケーションは少なく
TwitterやInstagramなどに投稿されているマリアージュを閲覧する際には
複数のアプリケーションを行き来するため、探しづらく、閲覧しづらいと感じていました。
そこで、一つのアプリケーションにまとめることができたら便利なのでは？と考え作成しました。

# 利用方法
##　トップページ（仮）
[![Image from Gyazo](https://i.gyazo.com/2b6b5cffdb87c7bd7517e6960ff5386a.gif)](https://gyazo.com/2b6b5cffdb87c7bd7517e6960ff5386a)
##　検索フォーム（仮）
[![Image from Gyazo](https://i.gyazo.com/1072dbfefea01af01af5df22f904d64f.gif)](https://gyazo.com/1072dbfefea01af01af5df22f904d64f)
## 詳細ページ（仮）
[![Image from Gyazo](https://i.gyazo.com/6b6c694ce778db02fbaa4ca557e47b74.gif)](https://gyazo.com/6b6c694ce778db02fbaa4ca557e47b74)

# 工夫したポイント
## トップページに必要以上の情報を表示させない
どういったアプリケーションなのかが分かるように、マリアージュとマリアーシュの説明を記述し
見やすいようにマリアージュは最新3件のみを表示させました。
## どこのページにいても検索できる
一覧表示ページへのリンクと検索フォームを、プルダウン形式でヘッダーに表示し
どこのページにいてもすぐに検索を可能にしました。
また、検索しやすいように、料理のタイプやお酒のテイストでのカテゴリ検索を実装しました。
## SNS認証の導入
ユーザー登録の際に、FacebookまたはGoogleアカウントでのSNS認証を導入し
登録をしやすくしました。

# 使用技術
## 開発環境
Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code
## 開発期間と平均作業時間
開発期間              ：8/6~8/20 (15日間)
1日あたりの平均作業時間 ：11
合計                 ：121時間

# 課題や今後実装したい機能
## ユーザー管理機能
- プロフィール編集機能
- パスワードを忘れた時の対応機能
## 法人アカウントの作成
- 飲食店や酒屋さんなどを対象に法人アカウント作成機能
- 法人アカウントの投稿は広告料に応じて検索上位に表示させるなどの特典を用意
## 詳細表示機能
- いいね機能
- コメント返信機能

# DB設計
## テーブル設計

### users テーブル

| Column             | Type   | Options                    |
| ------------------ | ------ | -------------------------- |
| email              | string | null: false , unique: true |
| encrypted_password | string | null: false                |
| nickname           | string | null: false                |

#### Association

- has_many :mariages
- has_many :comments

### mariages テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |   
| text             | text       | null: false                    |
| category_id      | integer    | null: false                    |
| taste_id         | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- has_many :comments

### comments テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| text         | string     | null: false                    |
| user_id      | references | null: false, foreign_key: true |
| mariage_id   | references | null: false, foreign_key: true |

#### Association

- belongs_to :mariage
- belongs_to :user 

## ER図
![ER図](https://user-images.githubusercontent.com/87063136/130400874-8bfbf34d-216e-43dc-9a64-0a1b540cf3f4.png)
