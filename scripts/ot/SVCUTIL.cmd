set project=%1
PUSHD "%~dp0..\..\..\%project%"
svcutil.bat Start
POPD
