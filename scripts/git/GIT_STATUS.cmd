@ECHO OFF
set arg1=%1
PUSHD "%~dp0..\..\..\%arg1%"
git status
POPD