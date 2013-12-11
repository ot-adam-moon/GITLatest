@ECHO OFF
set proj=%1
PUSHD "%~dp0..\..\..\%proj%"
git stash
POPD