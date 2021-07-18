Webパネルと拡張機能、検索エンジンを設定する。
<br>スタンドアロンが必要なものもあるので別途インストールすること。

# Webパネルに入れるもの
アカウントに紐付いたりインポート出来ないので、諦めて手動で追加する。

## 推奨
### コミュニケーション
- slack(https://app.slack.com/client/.../... :)
- [Twitter](https://twitter.com)
  - TweetDeckなどTwitter用Webクライアントサービスも候補
- [discord](https://discord.com)

### Webメーラー
- [Gmail](https://mail.google.com/mail)
- [Windows Live Mail(Outlook)](https://outlook.live.com/mail/0/inbox)

### 配信サイト
- [Youtube](https://www.youtube.com)

### ストレージ系
- [OneDrive](https://onedrive.live.com)
- [icloud](https://www.icloud.com)
- [GDrive](https://drive.google.com/drive/my-drive)
- [Dropbox](https://www.dropbox.com)
- [Amazon Drive](https://www.amazon.co.jp/clouddrive)

### 地図サービス。よく使う場所を指定して登録すると開いた瞬時に確認できる
- [GoogleMap](https://www.google.co.jp/maps/?hl=ja)
  - 所在地をクリップした状態にしておくとなお良し
### よく紛失するもの
- apps(chrome://apps/)
- [tor接続確認](https://check.torproject.org/)

## 候補
### 翻訳。複数持っておくとベター。拡張機能（後述）があるならそっちがおすすめ。重い場合はWebパネルを使う
- [Google翻訳](https://translate.google.co.jp/?hl=ja)
- [DeepL翻訳](https://www.deepl.com/ja/translator)
    
# 拡張機能
## セキュリティ
- [VPN Free - Betternet Unlimited VPN Proxy](https://chrome.google.com/webstore/detail/vpn-free-betternet-unlimi/gjknjjomckknofjidppipffbpoekiipm)
  - IPアドレスを隠したいだけならVPN Free。
- [Onion Browser Button](https://chrome.google.com/webstore/detail/onion-browser-button/fockhhgebmfjljjmjhbdgibcmofjbpca?hl=en)（[設定方法](https://qiita.com/___xxx_/items/b2a89082abd86b3e66e2)）
  - 匿名性が必要ならOnion Browser Button
- [SafeInCloud Password Manager](https://chrome.google.com/webstore/detail/safeincloud-password-mana/lchdigjbcmdgcfeijpfkpadacbijihjl)
  - [スタンドアローン](https://safe-in-cloud.com/en/#download)もインストールする必要がある。
- []()

## 翻訳。複数用意をする事が望ましいので、基本はDeepLで必要に応じてGoogleを使う想定とした
- [なぞり翻訳(英→和) for DeepL翻訳](https://chrome.google.com/webstore/detail/なぞり翻訳英→和-for-deepl翻訳/begokompmfdepmbdbemfahbeapcabeaa?hl=ja)
- [Google翻訳](https://chrome.google.com/webstore/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb?hl=ja): 初期設定時はドラッグ時にアイコンがちらついて鬱陶しいので消しておく

## トラッキング防止
やりすぎるとメモリをバカ食いするので、ほどほどにしよう。

- [Nano Adblocker](https://chrome.google.com/webstore/detail/nano-adblocker/gabbbocakeomblphkmmnoamkioajlkfo?hl=ja)
- [DuckDuckGo Privacy Essentials](https://chrome.google.com/webstore/detail/duckduckgo-privacy-essent/bkdgflcldnnnapblkhphbgpggdiikppg?hl=ja)
- [Avast Online Security](https://chrome.google.com/webstore/detail/avast-online-security/gomekmidlodglbbmalcneegieacbdmki?hl=ja)
- jsoff(ダウンロード先行方不明)
- [Skip Redirect](https://chrome.google.com/webstore/detail/skip-redirect/jaoafjdoijdconemdmodhbfpianehlon)

## 開発支援
- [Google Apps Script GitHub アシスタント](https://chrome.google.com/webstore/detail/google-apps-script-github/lfjcgcmkmjjlieihflfhjopckgpelofo/related?hl=ja): GAS Webエディタを使うならGithub連携に必須
- [OctoLinker](https://chrome.google.com/webstore/detail/octolinker/jlmafbaeoofdegohdhinkhilhclaklkp)
- [Short URL One Click](https://chrome.google.com/webstore/detail/short-url-one-click/opkochckhaddggppefiojeffdiaeimjm)
- [Chrometana - Redirect Bing Somewhere Better](https://chrome.google.com/webstore/detail/chrometana-redirect-bing/kaicbfmipfpfpjmlbpejaoaflfdnabnc)
  - Custom Search Engineに「https://websearch.rakuten.co.jp/Web?qt=」をいれておく。検索エンジン設定のような「%s」は不要。

# 検索エンジン
Webパネルではなく、[設定→検索エンジンの設定](vivaldi://settings/search/)

- [dockdockgo](https://duckduckgo.com): https://duckduckgo.com/?q=%s&t=vivaldi
- [楽天Web検索](https://websearch.rakuten.co.jp/Web?qt=%s)

# トラブルシューティング
## メモリバカ食い問題
これはvivaldiの問題ではなく、使い方の問題である事を念頭に置く。荒い使い方をしているとIE(Edge)でもFirefoxでもchromeでもメモリ消費量は変わらない。
<br>軽くするには、まず[拡張機能](chrome://extensions/)を見直すべきだ。
<br>タブなし、拡張機能も空っぽの状態だと300MBぐらいに落ち着くはずなので、起動直後に1Gを超えるようなら拡張機能を見直すか、不要なタブを休止状態にする。

たとえば、広告ブロッカーやサイトセキュリティは強力だがその性質上メモリをバカ食いする。
カードゲームと同じで、入れれば入れるだけ良いという事はない。ブラウザを起動する度に固まったり遅く感じる場合は、こういったツールが本当に必要か考え直そう。
