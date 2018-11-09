# Windowsショートカットを相対パスで設定する方法
%windir%\System32\rundll32.exe url.dll,FileProtocolHandler "(ショートカットを置いたフォルダ)\(実行ファイル)"

## 例：ShortcutIconsからTablacusExplorerを起動したい場合
%windir%\System32\rundll32.exe url.dll,FileProtocolHandler "..\TablacusExplorer\TE64.exe"

# ショートカット
## IIS(デフォルト).lnk
C:\inetpub\wwwroot

# スタートアップ用の設定
スタートアップに入れなくても起動してくれるようにタスクマネージャーを設定することも出来ますが、管理が煩雑になるので非推奨です。

## スタートアップ.lnk
C:\Users\(User)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

## スタートアップ.lnk以下に置くもの（一例）
関西弁Windowsとかも面白いかも

### DeleteMenu
動作環境がWin98～XPとありますが、Win10 Proで動いてます
https://forest.watch.impress.co.jp/article/2004/04/26/deletemenu.html

### 最前面でポーズ 1.03
同じくWindows 2000/XP/Vista/7/8とありますが、Win10 Proで動いています
https://so-zou.jp/software/pause/

