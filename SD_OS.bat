@echo off
ren %0 SD_OS.bat
cls		
TITLE SD_OS
set filelocation=C:\SDOS
CD C:/

goto install

:logind
color 0a
cls
echo.
set /p username=Username:

:login
color 0a
if %0 neq C:\SDOS\program\SD_OS.bat goto update
echo.

setlocal enabledelayedexpansion  &::this is required do not delete this allows the password system work


if exist SDOS\saves\users\%USERNAME% (
 cls
  echo.
  echo logging in as %USERNAME%
  echo.
  set /p password=< C:\SDOS\saves\users\%USERNAME%\password.SDPAS
  set /p passcode=Password:
) else (
 cls
  echo Creating profile...
  mkdir "C:\SDOS\saves\users\%USERNAME%"
  timeout /t 1 /nobreak>nul
 cls
  echo.
  set /p passcode=Set Password:
 cls
  echo.
  echo password set
  echo !passcode! > C:\SDOS\saves\users\%USERNAME%\password.SDPAS
  timeout /t 1 /nobreak>nul
 cls
  echo.
  echo setting everything up...
 PING localhost>nul
  goto login
)

if %passcode% equ %password% goto cl
 cls
color 04
echo.
echo password incorrect
timeout /t 2 /nobreak>nul
goto login

:cl

cls 
echo.
echo logged in as %USERNAME%


:mainloop
echo.
set action=blank
set /p action=what action would you like to preform=
echo.
if %action% equ help goto help
if %action% equ command goto command
if %action% equ color goto color
if %action% equ hack goto hack
if %action% equ flushdns goto flushdns
if %action% equ clear goto clear
if %action% equ start goto start
if %action% equ end goto end
if %action% equ plugins goto openpluginsfolder
if %action% equ logout goto logind

goto readplugins
goto mainloop

:openpluginsfolder
explorer "C:\SDOS\plugins"
echo opened plugins folder
goto mainloop

:readplugins
CD %filelocation%\plugins
if exist %action%.SDOSP goto perform
CD C:/
goto error

:perform
FOR /F "tokens=* delims=" %%x in (%action%.sdosp) DO %%x
cd c:/
goto mainloop


:start
set /p app=what application would you like to start=
start %app%
goto mainloop


:clear
cls
goto mainloop

:flushdns
ipconfig /flushdns
ping localhost>nul
ipconfig /registerdns
goto mainloop


:hack
color 0a
goto mainloop

:color
echo color
set /p FG=what color would you like to set the foreground to=
set /p BG=what color would you like to set the background to=
color %BG%%FG%
goto mainloop

:command
set /p command=what command would you like to proform=
%command%
goto mainloop

:help
echo.
echo.
echo   help
echo.
echo.
echo  to close the file type end
echo  for help type help
echo  command to preform a windows terminal command
ECHO  color to change the color
echo  clear to clear all messages
echo  flushdns to flush your dns
echo  start to start a program
echo  plugins to open the plugins folder
echo.
goto mainloop

:error
echo.
echo %action% is not a valid action
echo for help type help
echo.
goto mainloop




:end
echo closing
exit



:install
color 0a
echo configuring files
if exist SDOS\ (
  echo main file exists
  echo.
  goto checkintegrity
) else (
  echo making folder
  mkdir "C:\SDOS"
  mkdir "C:\SDOS\plugins"
  mkdir "C:\SDOS\saves"
  mkdir "C:\SDOS\saves\users"
  mkdir "C:\SDOS\program"
  copy %0 C:\SDOS\program
  echo.
  echo installing...
  timeout /t 5 /nobreak>nul
  start C:\SDOS\program\SD_OS.bat
  exit
)


:checkintegrity
echo checking integrity

if exist SDOS\plugins (
  echo.
  echo plugins exists
) else (
  echo.
  echo plugins does not exist
  echo creating plugins folder
  mkdir "C:\SDOS\plugins"
  echo.
)


if exist SDOS\saves (
  echo.
  echo saves exists
) else (
  echo.
  echo saves does not exist
  echo creating saves folder
  mkdir "C:\SDOS\saves"
  echo.
)

if exist SDOS\saves\users (
  echo.
  echo users exists
) else (
  echo.
  echo users does not exist
  echo creating users folder
  mkdir "C:\SDOS\saves\users"
  echo.
)



if exist SDOS\program (
  echo.
  echo program exists
) else (
  echo.
  echo program does not exist
  echo creating program folder
  mkdir "C:\SDOS\program"
  copy %0 C:\SDOS\program
  echo.
  start C:\SDOS\program\SD_OS.bat
  exit

)
echo.
echo configured
cls
goto login

:update
cd c:\SDOS\
del /f /q program

if exist SDOS\program (
  echo.
  echo an error has occured
) else (
  echo.
  echo updating...
  timeout /t 2 /nobreak>nul
  mkdir "C:\SDOS\program"
  copy %0 C:\SDOS\program
  start C:\SDOS\program\SD_OS.bat
  exit

   echo.
)