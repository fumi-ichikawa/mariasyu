
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
- URL     : https://mariasyu.com/
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
### トップページ
[![Image from Gyazo](https://i.gyazo.com/c3583e1c5e6ba12cb878c6ea7f842e05.gif)](https://gyazo.com/c3583e1c5e6ba12cb878c6ea7f842e05)
### 投稿ページ
[![Image from Gyazo](https://i.gyazo.com/76d5cf25f8744b687e023e38e1a927b6.gif)](https://gyazo.com/76d5cf25f8744b687e023e38e1a927b6)
### 検索フォーム
[![Image from Gyazo](https://i.gyazo.com/5332fbe7d01ea5c85e8cbb5078e24406.gif)](https://gyazo.com/5332fbe7d01ea5c85e8cbb5078e24406)
### 詳細ページ
[![Image from Gyazo](https://i.gyazo.com/b4a0ab7df74fd02e4a53901ea5db1671.gif)](https://gyazo.com/b4a0ab7df74fd02e4a53901ea5db1671)
### スマホからの閲覧
[![Image from Gyazo](https://i.gyazo.com/a4df505723211f2063f02a67e4c97152.gif)](https://gyazo.com/a4df505723211f2063f02a67e4c97152)

# 工夫したポイント
### ロゴデザイン・カラーセレクト
トップページのロゴは「お酒と食べ物は、組み合わせ次第で∞（無限）の可能性がある」という意味を込めて、∞に見えるような輪で囲んだデザインにしました。
また、検索フォームやボタンは、お酒を作る上で欠かせない「清らかな水」をイメージした、透き通るような水色を使用しました。
### SNS認証の導入
ユーザー登録の際に、FacebookまたはGoogleアカウントでのSNS認証を導入することで
パスワードの設定を省略し、登録をしやすくしました。
### SSL化・ドメインの取得
SNS認証導入に伴い、セキュリティの観点からSSL化を行いました。
ドメイン取得〜SSLサーバー証明書取得までの工程は、カリキュラムに無かった為
手探りでの実装になりましたが、大変学びが多い実装になりました。
### トップページに必要以上の情報を表示させない
どういったアプリケーションなのかが分かるように、マリアージュとマリアーシュの説明を記述し
見やすいようにマリアージュは最新3件のみを表示させました。
### どこのページにいても検索できる
一覧表示ページへのリンクと検索フォームを、プルダウン形式でヘッダーに表示し
どこのページにいてもすぐに検索を可能にしました。
また、検索しやすいように、料理のタイプやお酒のテイストでのカテゴリ検索を実装しました。
### 詳細ページでの画像表示をスライド化
複数画像投稿を可能にしたことにより、詳細ページでの画像表示が見づらくなってしまいました。
（具体的には、枚数が多ければ多いほどスクロールが必要になってしまいました。）
この問題を解決するために、詳細ページでは画像をスライドで表示させました。
### レスポンシブデザインの実装
いつでも、どこからでもアプリを使用してもらえるように、スマートフォンからの閲覧でも
レイアウトが崩れないように編集しました。

# 使用技術
### 開発環境
HTML/CSS/Ruby/Ruby on Rails/MySQL/Github/Jquery/AWS/Visual Studio Code
### 開発期間と平均作業時間
開発期間              ：8/6~8/29 (23日間)
1日あたりの平均作業時間 ：11
合計                 ：253時間

# 課題や今後実装したい機能
### ユーザー管理機能
- パスワードを忘れた時の対応機能
### 法人アカウントの作成
- 飲食店や酒屋さんなどを対象に法人アカウント作成機能
- 法人アカウントの投稿は広告料に応じて検索上位に表示させるなどの特典を用意
### 詳細表示機能
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
