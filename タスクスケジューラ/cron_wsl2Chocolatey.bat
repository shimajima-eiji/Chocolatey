@rem 日本語パスを扱う場合、文字コードはSJISにする必要がある。UTF8でもダメ。改行コードはCRLF
@rem %cron_pathは事前に設定しておく
@rem `SETX cron_path "(your path)"`
copy /Y \\wsl$\Ubuntu-20.04\home\ubuntu\cron\cron.sh %cron_path%
