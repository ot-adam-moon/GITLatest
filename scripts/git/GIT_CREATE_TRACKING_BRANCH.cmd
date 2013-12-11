set project=%1
set branch=%2
PUSHD "%~dp0..\..\..\%project%"
git submodule update
git pull upstream master
git fetch upstream
git checkout -t upstream/%branch%
POPD