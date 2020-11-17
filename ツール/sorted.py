from pathlib import Path
from datetime import datetime
import shutil
import sys
import re
from PIL import Image
from PIL.ExifTags import TAGS

class ExifImage:

  def __init__(self, fname):
    # 画像ファイルを開く --- (*1)
    self.img = Image.open(fname)
    self.exif = {"path": fname}
    if self.img._getexif():
      for k, v in self.img._getexif().items():
        if k in TAGS:
          if(TAGS[k] == "DateTimeOriginal"):
            self.exif[TAGS[k]] = v

  def print(self):
    if self.exif:
      for k, v in self.exif.items():
        print(k, ":", v)
    else:
      print("exif情報は記録されていません。")

  def getDate(self, todir):
    if "DateTimeOriginal" in self.exif:
      word = self.exif["DateTimeOriginal"]
      year = word[:4]
      month = word[5:7]
      # print("これ", todir.name, month, todir.parent.name, year)
      todir = todir / year / month

    else:
      path = Path(self.exif["path"])
      todir = pattern(path, todir)

    return todir

if __name__ == "__main__":
  def pattern(path, todir):
    def chkdir(path, todir):
      stat = datetime.fromtimestamp(path.stat().st_mtime)
      dirpath = todir / stat.strftime("%Y") / stat.strftime("%m")
      if not(todir.name == dirpath.name and todir.parent.name == dirpath.parent.name):
        todir = dirpath

      return todir

    m = re.findall('[\d]{8}', path.name)
    m2 = re.findall('[\d]{4}-[\d]{2}-[\d]{2}', path.name)
    m3 = re.findall('[\d]{2}-[\d]{2}-[\d]{2}', path.name)
    m4 = re.findall('[\d]{13}', path.name)

    if(len(m4) > 0):
      word = m4[0]
      year = word[:4]
      month = word[5:7]

      if(1970 <= int(year) <= 2020):
        todir = todir / year / month
      elif(1 <= int(month) <= 12):
        todir = todir / month
      else:
        todir = chkdir(path, todir)

    elif len(m) > 0:
      word = m[0]
      year = word[:4]
      month = word[4:6]

      if(1970 <= int(year) <= 2020):
        todir = todir / year / month
      elif(1 <= int(month) <= 12):
        todir = todir / month
      else:
        todir = chkdir(path, todir)

    elif len(m2) > 0:
      word = m2[0]
      year = word[:4]
      month = word[5:7]

      if(1970 <= int(year) <= 2020):
        todir = todir / year / month
      elif(1 <= int(month) <= 12):
        todir = todir / month

    elif len(m3) > 0:
      word = m3[0]
      year = str(2000 + int(word[:2]))
      month = Path(word[3:5])

      if(1970 <= int(year) <= 2020):
        todir = todir / Path(year) / month
      elif(1 <= int(month) <= 12):
        todir = todir / month
      else:
        todir = chkdir(path, todir)

    else:
      todir = chkdir(path, todir)

    return todir

  def move(path, todir):
    if(path.parent == todir):
      # print("skip: %s" % (path))
      return

    todir.mkdir(parents=True, exist_ok=True)
    shutil.move(path , todir / path.name)
    print("complete: %s -> %s" % (path, todir / path.name))

  def main(fromdir, targetdir, moviedir):
    rootdir = Path("/mnt/k")

    for path in fromdir.glob("**/*.*"):
      year = path.parent.parent.name
      month = path.parent.name

      # 既に整理済みのディレクトリは除外
      if year.isdecimal() and month.isdecimal():
        year = int(year)
        month = int(month)
        continue;

      # 画像 or 動画
      if path.suffix in [".JPG", ".jpg", ".JPEG", ".jpeg"]:
        todir = targetdir  # / "images"
        todir = ExifImage(path).getDate(todir)
      elif path.suffix in [".PNG", ".png", ".gif", ".GIF" ]:
        todir = targetdir
        todir = pattern(path, todir)
      elif path.suffix in [".mp4", ".MP4", ".mov", ".MOV", ".m2ts"]:
        todir = moviedir / path.parent.name
      elif ".tmp.drivedownload" in path.parts:
        continue  # Googleドライブのテンポラリディレクトリのためスキップ
      elif "Youtube" in path.parts:
        continue  # Youtube用のディレクトリは操作しない
      elif path.suffix in [".md"]:
        continue  # 説明書は移動しない
      else:
        todir = rootdir / "振り分け対象外"

      # 撮影機材
      # if path.name[:4] == "DJI_":
        # todir = todir / "OzmoPocket"
      # elif path.name[:4] == "IMG_":
        # todir = todir / "iPhone7plus"
      # else:
        # todir = todir / "未設定"

      move(path, todir)

  # 実行
  rootdir = Path("/mnt/k")

  fromdir = rootdir / "Amazon Drive/画像整理/Noomu"
  targetdir = rootdir / "Amazon Drive/画像整理/Noomu"
  moviedir = rootdir / "動画(Googleフォト用)/movie"
  main(fromdir, targetdir, moviedir)

  fromdir = rootdir / "Amazon Drive/画像整理/SO-03K"
  targetdir = rootdir / "Amazon Drive/画像整理/SO-03K"
  moviedir = rootdir / "動画(Googleフォト用)/同期"
  main(fromdir, targetdir, moviedir)

  fromdir = rootdir / "Amazon Drive/画像整理/Pixel 3a"
  targetdir = rootdir / "Amazon Drive/画像整理/Pixel 3a"
  moviedir = rootdir / "動画(Googleフォト用)/同期"
  main(fromdir, targetdir, moviedir)

  fromdir = rootdir / "Amazon Drive/画像整理/Ozmo Pocket"
  targetdir = rootdir / "Amazon Drive/画像整理/Ozmo Pocket"
  moviedir = rootdir / "動画(Googleフォト用)/同期"
  main(fromdir, targetdir, moviedir)
