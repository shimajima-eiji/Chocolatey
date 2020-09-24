:: 環境依存でバグがでているのか精査するためのクライアントバッチ
@echo off

SET LOGPATH=PCInfo\
md "%LOGPATH%" > NUL 2>&1

echo 結果表示に時間がかかります...
echo 結果はPCInfoフォルダ以下に保存します。
echo;

set YYYYMMDD=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%
set HHMMSS=%time:~0,2%%time:~3,2%%time:~6,2%
set HHMMSS=%HHMMSS: =0%

set FILEPATH=%LOGPATH%infomation.txt
set DIAGTMP=%LOGPATH%diagtmp_%computername%_%YYYYMMDD%_%HHMMSS%.txt

:: ログ取得
dxdiag /t %DIAGTMP%
echo %LOGPATH%%computername%_%YYYYMMDD%_%HHMMSS%>%FILEPATH%
systeminfo>>%FILEPATH%
type %DIAGTMP%>>%FILEPATH%
ipconfig /all>>%FILEPATH%
route print>>%FILEPATH%
tasklist /V /FO CSV>>%FILEPATH%
wmic PROCESS GET /FORMAT:CSV>%FILEPATH%_processlist.txt

del %DIAGTMP%

cls
echo 結果の取得が完了しました。

start "" explorer %LOGPATH%

echo この画面はもう使わないので、なにかキーを押すか閉じるボタンで終了してください
pause > nul
