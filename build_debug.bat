@echo off

REM Launch setup.bat
call setup.bat

REM Build project
cmake --build build --config Debug
