@echo off
set frompath=%~f1
set fromext=%2
set topath=%~f3
set toext=%4
rem  help message
if "%~5"=="" (
    @echo useage: %0 from_path from_file_filter to_path to_file_extension exe {exe parameters:_@fromfile, _@tofile,...} 
    @echo example: %0 d:\old *.txt d:\new txt copy _@fromfile _@tofile
    goto END
)
rem  look for all files
setlocal enabledelayedexpansion
set n=4
set exe_args=%5
set c=0
for %%i in (%*) do (
  set /a c+=1
  if !c! gtr %n% (set exe_args=!exe_args! %%i)
)
rem @echo exe_script !exe_args!
for /r "%frompath%" %%a in (%fromext%) do (
    rem  make file names
    set fromfile=%%~fa
    rem @echo fromfile  !fromfile!
    set fromfilenotext=%%~dpna
    rem @echo fromfilenotext  !fromfilenotext!
    set thisfrompath=%%~dpa
    rem @echo thisfrompath  !thisfrompath!
    set tofile=!fromfilenotext:%frompath%=%topath%!.%toext%
    rem @echo tofile  !tofile!
    set thistopath=!thisfrompath:%frompath%=%topath%!
    rem @echo thistopath  !thistopath!
    if not exist "!thistopath!" mkdir "!thistopath!"
    rem  make exe parameters script
    rem set exe_script=%exe_args%
    rem @echo exe_args %exe_args%
    rem @echo !exe_script!
    rem set exe_script=!exe_script:_@fromfile="!fromfile!"!
    rem set exe_script=!exe_script:_@tofile="!tofile!"!
    set exe_script=%exe_args:_@fromfile="!fromfile!"%
    set exe_script=!exe_script:_@tofile=!"!tofile!"!!
    rem  do task for every file
    rem @echo proc file: %%a
    @echo exe_script !exe_script!
    !exe_script!
    rem echo start /i /wait !exe_script! > 1.txt
    rem call !exe_script!
    rem @echo done file: !tofile!
)
endlocal

:END
pause