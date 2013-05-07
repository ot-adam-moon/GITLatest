@ECHO OFF
set project=%1
PUSHD "%~dp0..\%project%"
git clean -f
POPD
