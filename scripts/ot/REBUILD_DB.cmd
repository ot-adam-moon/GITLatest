@ECHO OFF
set arg1=%1
PUSHD "%~dp0..\..\..\%arg1%"
rebuild-db.bat /c exit %done%
POPD
IF %ERRORLEVEL% NEQ 0 (
	exit
)