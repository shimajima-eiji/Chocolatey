:: Get system info
@echo off

SET CPATH=%APPDATA%\Citrus\hokejyo\���̃t�H���_�̒��g���T�|�[�g�֑����Ă�������
md "%CPATH%" > NUL 2>&1

echo �f�f�������W���Ă���܂��B
echo ���̂܂܂��҂����������B
echo;

IF NOT "%CPATH:~-1%"=="\" SET CPATH=%CPATH%\

set YYYYMMDD=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%
set HHMMSS=%time:~0,2%%time:~3,2%%time:~6,2%
set HHMMSS=%HHMMSS: =0%

set LOGFNAME=%CPATH%infomation.txt
set DIAGTMP=%CPATH%diagtmp_%computername%_%YYYYMMDD%_%HHMMSS%.txt

dxdiag /t %DIAGTMP%

:LOOPLOOP
IF EXIST %DIAGTMP% GOTO :OKOKOKOK
ping localhost>nul
GOTO :LOOPLOOP

:OKOKOKOK
echo %CPATH%%computername%_%YYYYMMDD%_%HHMMSS%>%LOGFNAME%
systeminfo>>%LOGFNAME%
type %DIAGTMP%>>%LOGFNAME%
ipconfig /all>>%LOGFNAME%
route print>>%LOGFNAME%
tasklist /V /FO CSV>>%LOGFNAME%
wmic PROCESS GET /FORMAT:CSV>%LOGFNAME%_processlist.txt

del %DIAGTMP%

move infomation.txt ���̃t�H���_�̒��g���T�|�[�g�֑����Ă�������
move infomation.txt_processlist.txt ���̃t�H���_�̒��g���T�|�[�g�֑����Ă�������

cls
echo �f�f���̎��W���������܂����B
echo ���L��2�t�@�C�����T�|�[�g�ւ����t���������B
echo;
echo infomation.txt, infomation.txt_processlist.txt
echo;

start "" explorer %CPATH%

echo ������̃E�C���h�E�͉����L�[�������ƕ��܂��B
pause > nul

