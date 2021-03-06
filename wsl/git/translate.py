"""
# 使い方
curl https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/git/translate.py 2>/dev/null | python ${string}

# 注意点
予め実施しておく

- `pip install requests`

# 経緯
元々はshellでいい感じにやろうと思ったが、`{"code":200,"text":"*`のような形で引数受け取りの処理に失敗するので、pythonだけで実施する方針に変更
"""
import git


def translate(text):
  import requests
  import sys

  # if len(sys.argv)<2:
  #   print("[SKIP {}] 翻訳したい文字を引数に指定されていないため中止".format(sys.argv[0]))
  #   exit(1)

  # text=sys.argv[1]
  if not text:
    exit(1)

  url="https://script.google.com/macros/s/AKfycbzA5CyJFa8MQubeEL266bcfOqPcQpqBaH0Ta34nBBREH2IV5ss/exec"
  source=sys.argv[2] if len(sys.argv) > 2 else "en"
  target=sys.argv[3] if len(sys.argv) > 3 else "ja" if source == "en" else "en"

  params = (
    ('text', text),
    ('source', source),
    ('target', target),
    )

  response = requests.get(url, params=params)
  print(response.text)
