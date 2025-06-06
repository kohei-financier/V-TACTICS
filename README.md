## ■サービス概要

本サービスは、YoutubeやXなどに散在するValorant（ヴァロラント＜FPSゲーム＞）のテクニック情報を、効率的に検索・情報管理できるツールです。


検索したいキャラクター名などでテクニックをYoutubeとXを横断して検索できる機能や、ユーザーごとにブックマークやカテゴリ分けできる機能を実装し、
ユーザーが知りたいと思ったテクニックにすぐにアクセスできる環境を提供します。

## ■ このサービスへの思い・作りたい理由

Valorantには、エイムの練習法やキャラクターのスキルの使い方など、多くのテクニック情報が存在します。

しかし、これらの情報はYouTubeやXに大量に点在しており、周りの友人にヒアリングしたところ、「プロが使っているテクニックを調べたくても、なかなかすぐにたどり着けない」という悩みがあることが分かりました。

今日現在、テクニック情報を保存するには、Xでは「いいね」機能がありますが、他の投稿を「いいね」してしまうと埋もれやすく、
また、Xには「ブックマーク」機能でフォルダ分けができますが、現時点では有料のため気軽に利用できません。

そこで、知りたい攻略情報に素早くアクセスでき、必要なテクニックを情報をいつでも簡単に引き出せるサービスを開発したいと考えています。

メリットとしては、
- YoutubeやXを横断で検索できることで、今までノーマークだったテクニックの提供者の認知向上
- 新規プレイヤーにとっては、素早く知りたい情報にアクセスできることで、ゲームへの心理的ハードルも下がる

ことが考えられ、ゲームの盛り上がりにも寄与できるのではないかと考えています。

## ■ ユーザー層について

#### 1. プロやアマチュアプレイヤー
  - 上達を目指して、プロのテクニックや最新のメタなどを積極的に学びたい
  - テクニックをよく収集していて、効率よく検索・管理できる方法を模索している
#### 2. 初心者・新規プレイヤー
  - Valorantを始めたばかり or これからValorantを始めるユーザーで、基礎的なテクニックを調べたい
  - 周りに詳しい友人もおらず、どこから情報を得てよいのか分からない

## ■サービスの利用イメージ

- ユーザーが調べたい「キャラクター」や「マップ」をキーワードとしてテクニックを検索できる
- ユーザーはYoutubeやXの役立ったポイントやその動画秒数を簡単に記載して投稿。そのポイントを元に検索できる。
- ユーザーが気に入ったテクニックは、お気に入りマークを付けて保存ができる
- 投稿されたテクニックには情報源となるYoutubeチャンネルやXアカウントを記載。リンクできる。
- 自分の気になるカテゴリーをフォローでき、新着のテクニックを通知で受け取れる

## ■ ユーザーの獲得について

- 事前にある程度投稿しておき、MVPリリース時のコンテンツ充実度を担保する
- 友人やRUNTEQ内での認知、体験してもらう
- QiitaやZennなどの媒体での記事作成による認知
- Xでのシェア

## ■ サービスの差別化ポイント・推しポイント

**● 検索ワード入力すると、YoutubeとXを同時に検索**

→　ゲームに特化した「キャラクター名」×「マップ名」などの組み合わせ検索が可能

→　Turbo-Frame（待ち時間軽減）、stimulus（検索時のオートコンプリート）などを使用し、ユーザーの負担軽減も図る

**● プレビュー機能**

→　YoutubeやXの動画をページ内で直接再生可能。いちいち外部サイトに移動せずに済む。

**● お気に入り機能のカスタマイズ**

→　既存のサービスでは整理が難しい情報も、カテゴリーごとに整理可能

**● カテゴリーのフォロー機能＆通知機能**

→　カテゴリー（キャラ名など）をフォローしていると、新着のテクニック投稿があればお知らせを受け取れる

## ■ 機能候補

**【MVPリリース】**
- テクニックの投稿機能
- テクニックの一覧機能
- テクニックの検索機能（キャラクター・マップごと）
- お気に入り機能（※ MVPではカスタマイズできない）
- ユーザー登録・ログイン機能
- i18n
- 検索機能


**【本リリース】**
- ユーザー登録・ログイン機能（Google認証）
- お気に入りのカスタマイズ化（自身がつけたフォルダで管理できる）
- シェア機能
- カテゴリーのフォロー機能
- フォローしているカテゴリーに新規テクニックが投稿されたことをメールでお知らせ
- パンくずリスト
- DB永続化
- RSpec（モデルテスト・システムテスト）
- パスワードリセット
- メールアドレスリセット
- CI（GithubActions）
- ファピコン
- 独自ドメイン
- レスポンシブ対応

## ■ 機能の実装方針予定
| 機能            | 使用技術                                               |
|----------------|--------------------------------------------------------|
| Rails   | 7.2        |
| デプロイサーバー(Web)   | Render        |
| デプロイサーバー(DB)   | Neon        |
| DB   | PostgreSQL        |
| テクニック投稿の一覧表示   | iframe, blockquote        |
| テクニック投稿の検索   | Turbo-Frame, stimulus        |
| お気に入りのカスタマイズ | Sortable.js,acts-as-taggable-on                |
| 通知機能      | ActionMailer, SendGrid                             |
| ログイン機能    | devise+OmniAuth(GoogleOAuth2) |
| UI             | Tailwind CSS, DaisyUI                                   |

## 画面遷移図
[Figma](https://www.figma.com/design/sg79BYQysGnZ3rH7HbFXIe/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=ngO00vTTUwk5as8I-1)

## ER図
[dbdiagram](https://dbdiagram.io/d/valorant_portal-67c56c7a263d6cf9a0032850)
[![Image from Gyazo](https://i.gyazo.com/6cdd2c0680669c83647e487ac8af32b1.png)](https://gyazo.com/6cdd2c0680669c83647e487ac8af32b1)