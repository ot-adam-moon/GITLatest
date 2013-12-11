@ECHO OFF
set project=%1
PUSHD "%~dp0..\..\..\"
RD "%project%" /S /Q
POPD