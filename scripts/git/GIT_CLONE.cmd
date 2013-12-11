@ECHO OFF
set project=%1
PUSHD "%~dp0..\..\..\"
git clone git@github.com:OneTechLP/%project%.git -o upstream
POPD