@echo off

REM Go to batch path and one folder back
cd /D %~dp0
cd ../
set BATCHPATH=%CD%
cd /D %~dp0
set NEWPATH=%PATH%

REM STARTHERE:
REM Install ffmpeg
CALL :SetPathIfNot "%BATCHPATH%"
CALL :SetPathIfNot "%BATCHPATH%\ffmpeg"
CALL :SetPathIfNot "%BATCHPATH%\NpmUtils"

CALL :SetPathIfNot "%BATCHPATH%\ScriptCs"



REM ENDHERE
echo "Export new path"
SetEnv.exe -a PATH "%NEWPATH%"

pause
EXIT /B %ERRORLEVEL%

:SetPathIfNot
	set SEARCHPATH=%~1;
	Echo.%NEWPATH% | findstr /C:"%SEARCHPATH%" > nul && (
		REM DO NOTHING
		echo Already installed %~1
	) || (
		echo Install %~1 in PATH
		set "NEWPATH=%NEWPATH%;%~1"
	)
	EXIT /B 0