"""
# 概要
cronで日常的に実施しているコマンドが実行されていない事に跡から気付いた時に、手動で一括実施するために作成
ログイン中のユーザーの`crontab -l`の内容を時間順にソートして上からコマンドを実施する。

# 使い方
python <(curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/cron/manual.py 2>/dev/null)
この場合、bashかzshで動作確認。

0時0分からcronが動いていない事を想定しているので、たとえば10時まで動いていたような場合は本スクリプトを取得して
`lists["date"] <= today]`の行を`(lists["date"] <= today & lists["date"] >= (datetime))` のように書き換える
カッコ（）が最初と最後につくようになるので注意する

# 注意点
予め実施しておく

- `pip install pandas`

"""

# python3
import subprocess
from subprocess import PIPE
from datetime import datetime
import pandas as pd

# crontabを抽出
string="crontab -l"
proc = subprocess.run(string, shell=True, stdout=PIPE, stderr=PIPE, text=True)
lines = [line for line in proc.stdout.split("\n") if len(line.split()) > 5]
commands = [" ".join( line.split()[5:]) for line in lines]

# crontabの現在時間までの内容を抽出
today=datetime.today()
times=[line.split()[1::-1] for line in lines]
dates=[datetime(today.year, today.month, today.day, int(time[0]), int(time[1])) for time in times]

# 時間順にソートしたいのでpandasにする
def run(command):
  proc = subprocess.run(command + "; sleep 10", shell=True, stdout=PIPE, stderr=PIPE, text=True)
  print('COMPLETE: {}\nRESULT: {}'.format(command, proc.stdout))

lists = pd.DataFrame({"date":dates,"command": commands})
lists[lists["date"] <= today].sort_values("date")["command"].map(run)
