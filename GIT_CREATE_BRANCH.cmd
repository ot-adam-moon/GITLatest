@ECHO OFF
PUSHD "%~dp0..\%1"
git fetch
git checkout -B
POPD