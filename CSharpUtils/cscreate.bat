@echo OFF
set BATCHPATH=%~dp0

IF "%1" == "templates" (
	for /d %%D in ("%BATCHPATH%Templates\*") do (
		echo Template %%~nD
	)
	
	goto end
)

IF [%1] == [] (
	set /P RELDIR="Relative path: "
) ELSE (
	set RELDIR=%1
)

set /P TEMPLATE="Template [default]: " || SET "TEMPLATE=default"

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

set TEMPLATEFILE=%BATCHPATH%Templates\%TEMPLATE%
echo Template Dir %TEMPLATEFILE%

if exist %TEMPLATEFILE% (
    rem file exists
) else (
	echo Template %TEMPLATE% not found, check %BATCHPATH%Templates\
    set TEMPLATEFILE=%BATCHPATH%Templates\default\
)

xcopy "%TEMPLATEFILE%" "%cd%"
start cmd /c "%cd%\Main.cs"
:end