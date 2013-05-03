@ECHO OFF
set project=%1
PUSHD "%~dp0..\%project%"
run-me-first.bat
POPD