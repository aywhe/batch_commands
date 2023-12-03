echo off
set frompath=%~f1
set fromext=%2
set topath=%~f3
set toext=%4
:: help message
if "%~5"=="" (
    echo useage: %0 from_path from_file_filter to_path to_file_extension exe {exe parameters:_@fromfile, _@tofile,...} 
    echo example: %0 d:\old *.txt d:\new txt copy _@fromfile _@tofile
    goto END
)
:: look for all files
set n=5
set c0=0
setlocal enabledelayedexpansion
for /r "%frompath%" %%a in (%fromext%) do (
    :: make file names
    set fromfile=%%~fa
    ::@echo fromfile  !fromfile!
    set fromfilenotext=%%~dpna
    ::@echo fromfilenotext  !fromfilenotext!
    set thisfrompath=%%~dpa
    ::@echo thisfrompath  !thisfrompath!
    set tofile=!fromfilenotext:%frompath%=%topath%!.%toext%
    ::@echo tofile  !tofile!
    set thistopath=!thisfrompath:%frompath%=%topath%!
    ::@echo thistopath  !thistopath!
    if not exist "!thistopath!" mkdir "!thistopath!"
    :: make exe parameters script
    set exe_script="%~5"
    set c=%c0%
    for %%i in (%*) do (
      set /a c+=1
      if !c! gtr %n% (
          set ap=%%i
          if %%i equ _@fromfile (set ap="!fromfile!")^
          else if %%i equ _@tofile (set ap="!tofile!")
          set exe_script=!exe_script! !ap!
      )
    )
    :: do task for every file
    echo proc file: %%a
    echo !exe_script!
    start /i /d . /wait !exe_script!
    ::call !exe_script!
    echo done file: !tofile!
)
endlocal

:END
pause