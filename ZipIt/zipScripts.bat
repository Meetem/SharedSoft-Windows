@echo off
echo %1

set LastDir=%~n1
echo 
set /p ArchName=Set archive name (Default: %LastDir%.7z): 
IF NOT DEFINED ArchName SET "ArchName=%LastDir%.7z"

echo 
echo Writing to: %ArchName%
echo 

DEL /S /Q "%ArchName%"
"C:\Program Files\7-Zip\7z.exe" a -aoa -r -mmt4 -mx5 -x!System.* -x!UnityEngine.* -x!mscorlib.dll -x!DOTween* "%ArchName%" "%LastDir%\Managed"
pause