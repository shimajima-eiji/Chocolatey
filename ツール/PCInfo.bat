:: ���ˑ��Ńo�O���łĂ���̂��������邽�߂̃N���C�A���g�o�b�`
@echo off

SET LOGPATH=PCInfo\
md "%LOGPATH%" > NUL 2>&1

echo ���ʕ\���Ɏ��Ԃ�������܂�...
echo ���ʂ�PCInfo�t�H���_�ȉ��ɕۑ����܂��B
echo;

set YYYYMMDD=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%
set HHMMSS=%time:~0,2%%time:~3,2%%time:~6,2%
set HHMMSS=%HHMMSS: =0%

set FILEPATH=%LOGPATH%infomation.txt
set DIAGTMP=%LOGPATH%diagtmp_%computername%_%YYYYMMDD%_%HHMMSS%.txt

:: ���O�擾
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
echo ���ʂ̎擾���������܂����B

start "" explorer %LOGPATH%

echo ���̉�ʂ͂����g��Ȃ��̂ŁA�Ȃɂ��L�[������������{�^���ŏI�����Ă�������
pause > nul
