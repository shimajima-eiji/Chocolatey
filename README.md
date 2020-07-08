# Chocolatey
cinstで入れたパッケージ自体をバージョン管理するためのリポジトリ。
<br>[chocolateyの手引は解説サイトを参照](https://shimajima-eiji.github.io/resume/tech/chocolatey)していただいて、
<br>ここではインストールしたパッケージ自体を対象にする。

# ディレクトリ解説
管理者権限(ユーザーアカウント制御)が必要なので上書きして保存する運用にする。
<br>インストール先のディレクトリは「C:\ProgramData\chocolatey\lib\」

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

## 1. chocolatey本体のインストール
まっさらなWindows環境にchocolateyを入れる手順。
powershellを管理者権限で開き、

```
Get-ExecutionPolicy
# 初期だとRestrictedとなっているはず
Set-ExecutionPolicy AllSigned
# 何か言われたらうざったいのでA
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# ちまちまRしてたらうざったいのでA

# お好みでどうぞ
cinst (package-name or config-file)  # 初期値： chocolatey.config

## 途中、【Do you want to run the script?([Y]es/[A]ll - yes to all/[N]o/[P]rint):】と聞かれる事があるのでAとしておこう。

# やらなくても直ちに影響はないが、忘れずに戻しておこう
Set-ExecutionPolicy Restricted
```

を実施。
公式の手順だが情報が煩雑なため、このリポジトリの推奨手順として残す。
ほかのやり方でも出来れば何でもよい。

一応、`setup.ps1`を作ったが、これをそのまま実行できるかは微妙なところ。

## 2. chocolatey.configのインストール
あらかじめ作成しておいたxmlファイルを`choco install (chocolatey.config)`とする。
xmlの作成はchocolateyGUIなどを使うと楽ちん。

## 3. cinstディレクトリ：インストールしたアプリの各設定
管理者権限が必要になるので、実行時は要注意。

## 4. primitiveディレクトリ：WSLやVSCodeなど各設定
これはどうにもならないので、primitiveディレクトリに助けとなりそうなものを入れてある。

## その他
chocolatey.configで入っていないサードパーティーなど。

# トラブルシューティング
## エラーになる
管理者権限が必要だったり、choco系のコマンドにパスが通ってなかったりする。
パス設定が面倒なら同梱の.bash_profileを使うとよい。上書き注意。

## configファイルが読み込めない
文字コードなどが問題になることもある？ような気がするので、念の為【tools/config2bat.py】を作った。
chocolatey(GUI)でexportしたconfigファイルをbatで実行できるようにしたもの。
手動でpython(3)環境を作る必要はあるが、使うことはないはず。

生成したchocolatey.bat（変更可）は管理者権限で実行しよう。

## どうしてもうまくいかない
PowerShellとコマンドプロンプトの双方を使って、どちらかがうまく行けば良い。
いっそのこと乗り換えるという手も考えよう。

# chocolateyで入れたものを使う
主に愛用しているツールの解説。自分用の備忘録として。

## tablacus explorer
「C:\ProgramData\chocolatey\lib\tablacus」に設定が入っているので、この中を弄る。
tablacus以下のディレクトリをなんとなくそれっぽい場所に置けば設定が自動的に適用されていることがわかるはず。
インストール時点で入れたアドオンは消しているので、手間ならこのタイミングで削除してしまうとよい。

## WSL.sh
Ubuntuを想定している。
docker wslみたいなものがあれば楽だが、今の所見つからないのでWSL.shを実行する。

## VSCode
Settings Syncを入れてgithubログイン、Shift+P「sync」でダウンロードしたら環境構築が自動的に完了する。

## GoogleIME
宗教上の理由によりキー設定をATOKに。

# chocolateyで入らない便利なものを使う
## [tortoisegit](https://tortoisegit.org/download/)
[ダウンロード](https://tortoisegit.org/download/)

本体を入れてから日本語化パッチを当てよう。
