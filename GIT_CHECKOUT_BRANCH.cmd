@ECHO OFF
set project=%1
set branch=%2
PUSHD "%~dp0..\%project%"
git co %branch%
POPD