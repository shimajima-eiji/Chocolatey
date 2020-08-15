# 使い方
- windowsから見たパス:
  - \\wsl$
- VSCodeを使う場合:
  1. Remote WSLを入れる
  1. ターミナルをWSLで開き、`code ~/`
  1. WSLユーザーでVSCodeが起動する
  1. デバッガーなどWindowsとパスが異なる機能を使う拡張機能は別途設定・インストールを実施する
    - Settings Syncを使用している場合、Windows環境を上書きしないように注意
    - serviceなどは親ユーザーから実行する。WSLユーザーで実施するとパーミッションで弾かれる

# インストールコマンド
```
curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/ubuntu/pre-install.sh | sh
```

実行前に注意を促されるので、問題がなければsudoパスワードを入力する。
<br>実行の途中でタイムゾーンの設定ウィザードが起動する。

# CHANGELOG.mdについて
[Github_scoutのwikiを参照](https://github.com/shimajima-eiji/Github_scout/wiki/【手引】更新履歴（CHANGELOG.md）)
