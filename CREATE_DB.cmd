@ECHO OFF
set project=%1
PUSHD "%~dp0..\"
sqlcmd –E -S localhost\SQLSERVER –Q “create database ApplicationLog”
POPD