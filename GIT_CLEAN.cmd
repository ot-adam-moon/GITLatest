@ECHO OFF
set arg1=%1
PUSHD "%~dp0..\%arg1%"
git checkout -B %2
POPD