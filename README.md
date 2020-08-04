# Chocolatey
cinstで入れたパッケージ自体をバージョン管理するためのリポジトリ。
<br>[chocolateyの手引は解説サイトを参照](https://shimajima-eiji.github.io/resume/tech/chocolatey)していただいて、
<br>ここではインストールしたパッケージ自体を対象にする。

# ディレクトリ解説
管理者権限(ユーザーアカウント制御)が必要なので上書きして保存する運用にする。

- [cinst/tablacus/tools](https://github.com/shimajima-eiji/Chocolatey/tree/master/cinst/tablacus/tools)
  - パッケージを入れたあとに、それぞれのパッケージで追加設定が必要なもの。ここではTablacus Explorerを想定。なお、VSCodeやchromium系、ストレージ系はクラウド連携が使えるのでここでは考慮しない。
- [primitive](https://github.com/shimajima-eiji/Chocolatey/tree/master/tool)
  - Windows自体のプログラムと追加なりで対応するもの。だいたいWSLやタスクスケジューラー関連
- [ThirdParty.md](https://github.com/shimajima-eiji/Chocolatey/tree/master/ThirdParty.md)
  - cinst(chocolatey.configをinstall)では入らないもの。ダウンロードパスやMSストアを列挙
- [tool](https://github.com/shimajima-eiji/Chocolatey/tree/master/primitive)
  - もしchocolatey.packageがインポートできない場合の予備案。動作未確認。

# インストール手引き
作業としては

1. chocolatey本体のインストール
1. chocolatey.configのインストール
1. cinstディレクトリ：インストールしたアプリの各設定
1. primitive

だけ順番があり、以降は順不同で実施できる。解説は後述の通り。

https://github.com/shimajima-eiji/Chocolatey/wiki/Chocolateyのインストール・アップグレード

# インストール後
https://github.com/shimajima-eiji/Chocolatey/wiki/設定が必要なサードパーティー
