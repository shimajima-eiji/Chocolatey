@rem 日本語パスを扱う場合、文字コードはSJISにする必要がある。UTF8でもダメ。改行コードはCRLF
@rem %cron_pathは事前に設定しておく
@rem `SETX from_cron"(your path)"`
@rem `SETX to_cron"(your path)"`
copy /Y %from_cron% %to_cron%
