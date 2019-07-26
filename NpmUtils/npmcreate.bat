@echo OFF
set BATCHPATH=%~dp0
SETLOCAL ENABLEDELAYEDEXPANSION


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

mkdir "%ABSPATH%"
cd /D "%ABSPATH%"

call npm init -y

set TEMPLATEFILE=%BATCHPATH%Templates\%TEMPLATE%
echo Template Dir %TEMPLATEFILE%

if exist %TEMPLATEFILE% (
    rem file exists
) else (
	echo Template %TEMPLATE% not found, check %BATCHPATH%Templates\
    set TEMPLATEFILE=%BATCHPATH%Templates\default\
)

for /F "tokens=*" %%A in (%TEMPLATEFILE%\packagesList.txt) do (
	Echo.%%A | findstr /C:"//" > nul && (
		REM COMMENT
	) || (
		Echo.%%A | findstr /C:"local:" > nul && (
			set PKG=%%A
			set PKG=!PKG:~6!
			set PKG=%BATCHPATH%LocalPackages\!PKG!
			echo Local !PKG!
			call npm install !PKG!
		) || (
			set PKG=%%A
			echo Global !PKG!
			call npm install !PKG!
		)
	)
)

xcopy "%TEMPLATEFILE%" "%cd%"
del /s /q packagesList.txt

start cmd /c "%cd%\index.js"

:end