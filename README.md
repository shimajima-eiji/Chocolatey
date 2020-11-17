# Chocolatey
`cinst`(`chocolatey install`)で入れたパッケージ自体をバージョン管理するためのリポジトリ。
<br>[chocolateyの手引は解説サイトを参照](https://shimajima-eiji.github.io/resume/tech/chocolatey)し、
<br>ここではインストールしたパッケージ自体を対象にする。

# ディレクトリ解説
管理者権限（ユーザーアカウント制御）が必要なので上書きして保存する運用にする。
<br>`C:\ProgramData\chocolatey`にリポジトリを置く場合、`.\config\chocolatey.config`を誤って変更しないように注意。

なお、chocolateyでインストールされたパッケージは`C:\ProgramData\chocolatey`に格納される。
<br>ここでは、`C:\ProgramData\chocolatey`に`.git`フォルダを置いて運用することを想定して解説する。

- [lib](https://github.com/shimajima-eiji/Chocolatey/tree/master/lib)
  - パッケージインストール後に導入が必要なもの。初回時のみ上書き可能なもの。なお、VSCodeやchromium系、ストレージ系はアカウントログインによるクラウド連携が使えるのでここでは考慮しない。
- [wsl](https://github.com/shimajima-eiji/Chocolatey/tree/master/wsl)
  - タスクスケジューラやcronなど環境構築を一元化しているので、必要なものに絞って使用を推奨。
- [ツール](https://github.com/shimajima-eiji/Chocolatey/tree/master/ツール)
  - もしchocolatey.packageがインポートできなかった場合の予備案。動作未確認。toolというややこしいフォルダが存在する。
- [タスクスケジューラ](https://github.com/shimajima-eiji/Chocolatey/tree/master/タスクスケジューラ)
  - 設定方法についてはREADMEを参照する。
- [追加設定](https://github.com/shimajima-eiji/Chocolatey/tree/master/追加設定)
  - インストール後に設定が必要なものは`パッケージ.md`を、サードパーティーサービスは`WebService.md`に集約している。

# インストール手引き
作業としては

1. chocolatey本体のインストール
1. chocolatey.configのインストール
1. 本リポジトリを`C:\ProgramData\chocolatey`に格納
1. 必要に応じて追加設定など

だけ順番があり、以降は順不同で実施できる。解説は後述の通り。

https://github.com/shimajima-eiji/Chocolatey/wiki/Chocolateyのインストール・アップグレード

# インストール後
https://github.com/shimajima-eiji/Chocolatey/wiki/設定が必要なサードパーティー

# トラブルシューティング
https://github.com/shimajima-eiji/Chocolatey/wiki/トラブルシューティング
