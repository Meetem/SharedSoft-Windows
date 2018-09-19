@echo OFF
set BATCHPATH=%~dp0

IF [%1] == [] (
	set /P RELDIR="Relative path: "
) ELSE (
	set RELDIR=%1
)

set /P TEMPLATE="Template [default.cs]: " || SET "TEMPLATE=default.cs"

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

set TEMPLATEFILE=%BATCHPATH%Templates\%TEMPLATE%
echo Template File %TEMPLATEFILE%

if exist %TEMPLATEFILE% (
    rem file exists
) else (
	echo Template %TEMPLATE% not found, check %BATCHPATH%Templates\
    set TEMPLATEFILE=%BATCHPATH%Templates\default.cs
)

copy %TEMPLATEFILE% main.cs
call main.cs