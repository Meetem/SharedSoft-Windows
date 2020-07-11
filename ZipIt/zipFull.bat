@echo off
echo %1

set LastDir=%~n1
set /p ArchName=Set archive name (Default: %LastDir%.7z): 
IF NOT DEFINED ArchName SET "ArchName=%LastDir%.7z"

echo ''
echo Writing to: %ArchName%
echo ''

"C:\Program Files\7-Zip\7z.exe" a -aoa -r -mmt4 -mx5 %ArchName% "%1"