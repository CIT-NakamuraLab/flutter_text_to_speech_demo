# text_to_speech_demo

## 音声通話補助アプリ**comecome**のデモアプリケーション

**このアプリは､日常で利用する言葉を押すことによって音声となり出力されるシンプルなアプリです**

## 目次
- [text\_to\_speech\_demo](#text_to_speech_demo)
  - [音声通話補助アプリ**comecome**のデモアプリケーション](#音声通話補助アプリcomecomeのデモアプリケーション)
  - [目次](#目次)
  - [機能](#機能)
  - [操作方法](#操作方法)


## 機能
- カードを押すことによって欲しい物を呼ぶことができる機能
- スマホを振ることで名前を呼ぶことができる機能
- 画面遷移及びデータを更新した際にも状態を読み上げる機能
- カードを追加できる機能
- カードを編集できる機能
- カードを削除できる機能
- 入力ページに遷移すれば､フリック入力をしなくても入力することができる機能

## 操作方法

初期画面にアクセスすると､カテゴリー分けされたカードと名前入力欄及び他の画面へ遷移するナビゲーションバーが表示される

![home_init](/assets/images/readme/home_init.png)


飲み物や道具ボタンを押すことで画面が遷移し､それぞれのカードが表示されて追加､編集､削除をすることができる(カードを下に引っ張ることで､データを更新することができる)

![drink](/assets/images/readme/drink.png)
![tool](/assets/images/readme/tool.png)

右下にある追加アイコンを押すことで､モーダルが表示されてカードを追加できる

![drink_addCard](/assets/images/readme/drink_addCard.png)

カードの一番左にあるお気に入りアイコンを押すことで､後述するお気に入り画面にて表示される

![drink_favorite](/assets/images/readme/drink_favorite.png)

カードの右から2つめの編集アイコンを押すことで､モーダルが表示されてカードを編集することができる

![drink_editCard](/assets/images/readme/drink_editCard.png)

カードの一番右にある削除アイコンを押すことで､ダイアログが表示されて削除することができる

![drink_removeCard](assets/images/readme/drink_removeCard.png)

お気に入り画面に遷移すると前述したお気に入りカードを画面上に出力する(「お気に入りカードが存在しません」テキストボタンを押すことで､データを更新することができる)

![favorite_init](/assets/images/readme/favorite_init.png)

更新するとお気に入りに入れたカードが表示される

![favorite_card](/assets/images/readme/favorite_card.png)

入力画面では､フリック入力が苦手な人でも打ち込めるようにボタンを押すことで他者に伝えることができる

![input_call](/assets/images/readme/input_call.png)