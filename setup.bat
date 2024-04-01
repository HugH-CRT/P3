@echo off

REM If output directory exists, remove it
if exist output rmdir /s /q output

REM Setup libs
if not exist libs mkdir libs
cd libs 
if not exist debug mkdir debug
if not exist release mkdir release
cd ..

REM Copy all .lib and .dll files from extern directory to libs directory

set "source=%~dp0\extern"
set "destination_debug=%~dp0libs\debug"
set "destination_release=%~dp0libs\release"

for /R "%source%" %%f in (*.dll *.lib) do (
    REM copy in debug directory if it is a debug build else copy in release directory else copy in both
    
    echo.%%f | findstr /I /C:"\\debug\\" 1>nul
    if errorlevel 1 (
        echo.%%f | findstr /I /C:"\\release\\" 1>nul
        if errorlevel 1 (
            REM copy in both directories
            copy "%%f" "%destination_debug%"
            copy "%%f" "%destination_release%"
        ) else (
            REM copy in release directory
            copy "%%f" "%destination_release%"
        )
    ) else (
        REM copy in debug directory
        copy "%%f" "%destination_debug%"
    )
)
    
REM Setup with CMake (P3 Project)
cmake -B build

pause