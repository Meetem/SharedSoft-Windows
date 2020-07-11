@echo off
SETLOCAL
SET mystring=%~dp0
SET mystring=%mystring:\=\\%

echo Windows Registry Editor Version 5.00 > zipIt.reg

echo [HKEY_CLASSES_ROOT\Directory\shell\ubuild] >> zipIt.reg
echo @="Zip Unity &Data" >> zipIt.reg

echo [HKEY_CLASSES_ROOT\Directory\shell\ubuild\command] >> zipIt.reg
echo @="\"%mystring%zipFull.bat\" \"%%1\"" >> zipIt.reg

echo [HKEY_CLASSES_ROOT\Directory\shell\ubuilds] >> zipIt.reg
echo @="Zip Unity &Shallow" >> zipIt.reg

echo [HKEY_CLASSES_ROOT\Directory\shell\ubuilds\command] >> zipIt.reg
echo @="\"%mystring%zipShallow.bat\" \"%%1\"" >> zipIt.reg

start zipIt.reg