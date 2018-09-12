@echo OFF
set BATCHPATH=%~dp0

IF ["%1"] == [] (
	set /P RELDIR="Relative path: "
) ELSE (
	set RELDIR=%1
)

set /P TEMPLATE="Template [default.js]: " || SET "TEMPLATE=default.js"

set ABSPATH=%CD%\%RELDIR%

REM Trying to find is RELDIR actually absolute
Echo.%RELDIR% | findstr /C:":/" > nul && (
	set ABSPATH=%RELDIR%
) || (
	REM 1
)

REM Trying to find is RELDIR actually absolute	
Echo.%RELDIR% | findstr /C:":\\" > nul && (
	set ABSPATH=%RELDIR%
) || (
	REM 2
)

mkdir %ABSPATH%
cd %ABSPATH%

call npm init -y
call npm install string-format

copy %BATCHPATH%Templates/%TEMPLATE% index.js
call index.js
pause