@echo OFF
set BATCHPATH=%~dp0

IF [%1] == [] (
	set /P RELDIR="Relative path: "
) ELSE (
	set RELDIR=%1
)

set /P TEMPLATE="Template [default.js]: " || SET "TEMPLATE=default.js"

SET RELDIR=%RELDIR:/=\%
set ABSPATH=%CD%\%RELDIR%

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
call npm install split-string
call npm install async-foreach

set TEMPLATEFILE=%BATCHPATH%Templates\%TEMPLATE%
echo Template File %TEMPLATEFILE%

if exist %TEMPLATEFILE% (
    rem file exists
) else (
	echo Template %TEMPLATE% not found, check %BATCHPATH%Templates\
    set TEMPLATEFILE=%BATCHPATH%Templates\default.js
)

copy %TEMPLATEFILE% index.js
call index.js
pause